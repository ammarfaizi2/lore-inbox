Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUBYQPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUBYQPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:15:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261401AbUBYQP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:15:29 -0500
Message-ID: <403CCA10.7030906@pobox.com>
Date: Wed, 25 Feb 2004 11:15:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: PRD_ENTRIES is 256
References: <20040225095317.GJ693@holomorphy.com> <200402251411.13945.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402251411.13945.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 25 of February 2004 10:53, William Lee Irwin III wrote:
> 
>>PRD_ENTRIES is specified to be precisely 256; on platforms where
>>PAGE_SIZE varies from 4KB the calculation in the current expression
>>defining it is inaccurate, which may cause crashes. This patch changes
>>it to the constant literal 256.
> 
> 
> Ok, thanks.  However I cannot find 256 entries limit in any ATA document
> and from looking at the code 512 entries shouldn't be a problem (?).


I can't find the 256 limit either, but I would swear it exists...  I'll 
ask around.  Certainly it would be nice for lba48 to have larger tables...

	Jeff



