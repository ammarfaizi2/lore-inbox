Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbUCNGMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbUCNGLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:11:45 -0500
Received: from fmr05.intel.com ([134.134.136.6]:8924 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263309AbUCNGJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:09:00 -0500
Subject: Re: Kernel 2.6.2 reboot hangs on AMD Athlon System
From: Len Brown <len.brown@intel.com>
To: Sascha Wilde <wilde@sha-bang.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F4EB9@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4EB9@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1079244503.2173.142.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Mar 2004 01:08:25 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Curious that this happens
1. only on 2.6
2. with acpi=off and "acpi=on"

Would be good to know that the system is running the latest BIOS.

cheers,
-Len

On Fri, 2004-03-12 at 18:36, Sascha Wilde wrote:
> Hello,
> 
> I have a strange Problem with all 2.6.x kernels (and only with
> these): my box refuses to reboot.
> 
> 
> The Problem:
> 
> All versions of Linux 2.6.x (I started testing with 2.6.test6 and the
> latest version I tied was 2.6.4 release) cause my System to hang when
> I try to reboot (or power off).
> 
> 
> The Hardware:
> 
> The system in question is a x86 PC with:
> AMD Athlon(tm) Processor stepping 02 CPU (classic 800MHz)
> AMD Irongate chipset 
> 
> This list is quite short, for I have no idea which components could be
> related to the problem.  I will provide you with any further
> information needed or send you a full kernel startup log if wanted.
> 
> 
> What I tried:
> 
> The problem occurs at the end of any shut-down process, right when
> the system should reboot (or power off).  I tried different Kernel
> versions (form 3.6.test6 to 2.6.4) using different compiler
> tool-chains and configurations.  It also tried a kernel 2.6.1 from a
> "Knoppix" CD distribution, so this is unrelated to my compiler.
> 
> I tried booting into single user and rebooting via sysreq-keys, it
> made the machine hang, too -- so I would say the userland is not
> involved.
> 
> During digging in the dark I also tried different power-management
> configurations with APM and ACPI, no chance (normally I use APM).
> 
> This is only a 2.6.x matter, all earlier Kernels I used (including
> some 2.2.x versions and nearly every 2.4.x version), the netbsd
> kernel (1.6.1 and 1.6.2) and the grub bootloader are able to reboot
> the system as expected.
> 
> 
> This problem is 100% reproducible on my box, but I haven't yet found
> any other system showing this symptoms.
> 
> Sorry for this very vague report, but I have simply no idea, what
> might be the cause.
> 
> Please CC me in any answers, I'm not subscribed to the lkml.
> 
> cheers
> sascha
> 
> ps. please don't mind my worse English.
> -- 
> Sascha Wilde
> ... mein Opa [...]  würde an dieser Stelle zu Dir sagen: Junge, such
> Dir 
> ne Frau, bau Dir ein Haus, mach ein Kind und laß' die Finger von dem
> Zeug,
> das Du gerade machst. -- Michael Winklhofer in d.a.e.auktionshaeuser
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

