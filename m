Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTI0Ovw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTI0Ovw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 10:51:52 -0400
Received: from web40904.mail.yahoo.com ([66.218.78.201]:45467 "HELO
	web40904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262454AbTI0Ovu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 10:51:50 -0400
Message-ID: <20030927145149.65265.qmail@web40904.mail.yahoo.com>
Date: Sat, 27 Sep 2003 07:51:49 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
To: Jean-Marc@Spaggiari.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Spaggari,

> (as you can see, i'm a newbie of english speeking, and linux-kernel posting, so, 
> excuse me if this is a duplicate contribution, I have search on the web and on the
> archive and fine nothing about this error.)
>
>
> Error message :
> VFS : Cannot open root device "302" or unknown-block(3,2)
> Please append a corect "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on unknown-block(3,2)
>
>
> Kernel version : 2.6.0-test5
>
> System : Toshiba Satellite laptop
>
> More information : Linux is installe on /deh/hda2. There 2 other kernel on this
> computer. A 2.2.20 and a 2.4.22, both of them working fine. Ia have try many 
> differend option for compile the kernel, but never working any more. My /dev/hda2
> is on ext3.
>
> I will try soon on my other systems.
>
> I will be hapy if I can help in any kind, so, at this time, i'm going back to
> 2.4.22. (Need I to poste my .config here ?)

Please do so. Specifically, post the part of your .config which shows how your
filesystems are configured. It looks to me like you may have accidentally compiled
ext3 as a module; if your / filesystem is ext3, it must be compiled into the kernel
in order for the kernel to mount your root filesystem and run /sbin/init.

> 
> Regards,
>
> Jean-Marc Spaggiari (QC.CA)

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
