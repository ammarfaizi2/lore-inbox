Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbUCTKWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbUCTKWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:22:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263336AbUCTKV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:21:29 -0500
Message-ID: <405C1B1C.4000804@pobox.com>
Date: Sat, 20 Mar 2004 05:21:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com> <200403200224.14055.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403200224.14055.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Yep but in your original mail you suggested that we should explicitly enable
> FLUSH CACHE and FLUSH CACHE EXT features - there are even no subcommands
> to do this.  ;-)

Whoops, you're right.  I was thinking about the general protocol for 
features.


> I wish it was so simple.  Here is an example to make it clear:
> 
> model: WDC WD800JB-00CRA1 firmware: 17.07W77
> word 0x83 is 4b01, word 0x86 is 0x0801
> 
> and drive of course supports CACHE FLUSH command.

What ATA revision?

Sending down opcodes because they will "probably" work isn't the best 
idea in the world...

	Jeff



