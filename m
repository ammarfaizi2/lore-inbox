Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbULLEM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbULLEM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 23:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULLEM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 23:12:28 -0500
Received: from picard.ine.co.th ([203.152.41.3]:8396 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261183AbULLEMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 23:12:20 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41BB32A4.2090301@pobox.com>
References: <1102752990.17081.160.camel@cpu0>  <41BAC68D.6050303@pobox.com>
	 <1102760002.10824.170.camel@cpu0>  <41BB32A4.2090301@pobox.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102824735.17081.187.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Dec 2004 11:12:15 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 00:47, Jeff Garzik wrote:
...
> All 2.6 kernels work with 64bit and >4GB memory, on my configurations 
> (x86-64, ia64, and alpha).
> 
> It is a mistake to assume that all 64bit and/or >4GB is broken.
> 
> > (Tiger K8W, dual Opteron)
> 
> Ok, we finally get a bit of useful information.
> 
> Are you CERTAIN that you are booting a 64bit kernel?
> Is your memory PC1600, PC2100, or PC2700?
> Is your memory installed in matched pairs?
> Is all your memory ECC registered?
> Is your BIOS at the latest version?

Hi Jeff,

"yes" to all of the above. I am 100% certain this is not a
hardware problem. I have paired simms and with a 32 bit kernel
can use the entire 4GB. I also have run memtest86 ...

> Once we get through the hardware issues, now it is time to do a binary 
> search of 2.6 kernels, to see which one works for you.  If no 2.6 
> kernels work for you, then give 2.4 kernels a try.
> 
> 	Jeff

I have previously reported this bug to the list (about a week
ago). I am greatfull for every response and am willing to
investigate everything.

Previously I was running Fedora Core 2 32BIT with the 2.6.9
kernel and never had problems with 4GB. After finally upgrading
to 64 bit I can't use 4GB memory anymore.


# ver_linux

Linux cpu10 2.6.9RU1.1 #11 SMP Sun Dec 5 11:42:18 ICT 2004 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         autofs4 nfs lockd sunrpc binfmt_misc dm_mod button battery ac nvidia ipv6 ohci_hcd uhci_hcd ehci_hcd hw_random snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore floppy


The attached boot log shows the kernel panic ....

Kind Regards,
rudi

