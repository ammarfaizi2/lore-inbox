Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270330AbUJUEPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270330AbUJUEPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbUJUEJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:09:04 -0400
Received: from fmr06.intel.com ([134.134.136.7]:933 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270581AbUJUEEO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:04:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 12:03:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFD2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS2ImyJI6PAJJkgQluksSlJ5RkFTAA/94Vg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Kendall Bennett" <kendallb@scitechsoft.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "fbdev" <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 21 Oct 2004 04:03:40.0237 (UTC) FILETIME=[F2BB9FD0:01C4B722]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is hard to use native VGA for s3 debugging. 
I don know if serial console or net console 
can help s3 debugging. 

Thanks
Luming 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Pavel Machek
>Sent: 2004Äê10ÔÂ20ÈÕ 5:09
>To: Jon Smirl
>Cc: Kendall Bennett; Alan Cox; Linux Kernel Mailing List; fbdev
>Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
>
>Hi!
>
>> > What about non-x86 platforms such as PowerPC and MIPS 
>embedded devices
>> > that want video (TiVo type platforms, media players etc). 
>How would these
>> > fit into the picture? Would this require the boot loader 
>(ie: U-Boot or
>> > whatever) to have the ability to POST the card?
>> 
>> There is the assumption that whatever BIOS the device has 
>can get up a
>> very early console that can output critical error messages before the
>> kernel and early user space is loaded. For example the "I can't find
>> the kernel" or  "initramfs is missing" error message. This also
>> assumes that the BIOS can post whatever display it is using.
>> 
>> I'm not trying to fix the problem of getting early boot messages out
>> of a Mac with an x86 card plugged into it. The card will work after
>> early user space initializes. The right way to fix that would be to
>> switch to something like LinuxBIOS and build the x86 emulator into
>> it.
>
>That still does not solve resume from suspend-to-RAM. We need to post
>VGA there. We probably could do it late in userspace... but it makes
>debugging resume pretty hard.
>								Pavel
>-- 
>People were complaining that M$ turns users into beta-testers...
>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
