Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265039AbUFAN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbUFAN3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFAN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:29:32 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:43498 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265036AbUFAN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:29:15 -0400
Message-ID: <40BC84A2.5030608@ThinRope.net>
Date: Tue, 01 Jun 2004 22:29:06 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Marco Marabelli <mm@smrt.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: probls upgrading ram on a 2.4 linuxbox
References: <20040601094948.20990.qmail@apollo.survival>
In-Reply-To: <20040601094948.20990.qmail@apollo.survival>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Marabelli wrote:
> 
> 
> 
> 
> On Tuesday 01 June 2004 12:19, Marco Marabelli wrote:
> 
>> > Hi all!
>> > As subject I upgraded my box from 1GB ram to 2GB ram; bios sees all
>> >new memory but kernel doesn'load (error in memory stack).
> 
> 
>> Details??
> 
> 
>> > I have the kernel set with CONFIG_HIGHMEM4G.
>> > I googled everywhere but didn't find any similar problem.
>> > Anyone has a suggestion?
>> > linux 2.4.18 (slackware) on 2x1.6 athlon processor, ram266Mhz no ECC.
Probably CONFIG_HIGHMEM4G is notrelated...

> Unfortunately I didn't note exactly the error output, I will try tonight 
> again (it's a server on production), but:
> - with 2GB, after lilo black screen ...
> - with 1.5GB, the kernel stops after detecting SCSI drive, with a long 
> output that explaned a memory error in stack ...
> - obviously, rebooting with 1GB everything works ...
I bet it is faulty RAM (hardware bug). To be sure run memtest http://memtest.org/ for a few hours if possible
Try running with 1GB, but with the new DIMM (t.e. just exchange the DIMMs).
If this works, put now the old DIMM back, but on different DIMM slot and try memtest.

Report back.

> in a few hours I can report in ML the details ... (waiting for offices 
> to close)
> thanks in advice,
> Marco Marabelli

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
