Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUJDQcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUJDQcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUJDQcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:32:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268095AbUJDQaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:30:55 -0400
Message-ID: <41617AB2.4030702@pobox.com>
Date: Mon, 04 Oct 2004 12:30:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: William Knop <wknop@andrew.cmu.edu>, Jon Lewis <jlewis@lewis.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com> <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu> <4161750A.6060200@rtr.ca>
In-Reply-To: <4161750A.6060200@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> I have used Maxtor "SATA" drives that require
> the O/S to do a "SET FEATURES :: UDMA_MODE" command
> on them before they will operate reliably.
> This despite the SATA spec stating clearly that
> such a command should/will have no effect.
> 
> I suppose libata does this already, but just in case not..
> Something simple to check up on.

libata always issues SET FEATURES - XFER MODE.

	Jeff


