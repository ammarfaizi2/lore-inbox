Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUCLXgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUCLXgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:36:47 -0500
Received: from mail1.kontent.de ([81.88.34.36]:39064 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262465AbUCLXgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:36:16 -0500
Date: Sat, 13 Mar 2004 00:36:14 +0100
From: Sascha Wilde <wilde@sha-bang.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.2 reboot hangs on AMD Athlon System
Message-ID: <20040312233614.GA641@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a strange Problem with all 2.6.x kernels (and only with
these): my box refuses to reboot.


The Problem:

All versions of Linux 2.6.x (I started testing with 2.6.test6 and the
latest version I tied was 2.6.4 release) cause my System to hang when
I try to reboot (or power off).


The Hardware:

The system in question is a x86 PC with:
AMD Athlon(tm) Processor stepping 02 CPU (classic 800MHz)
AMD Irongate chipset 

This list is quite short, for I have no idea which components could be
related to the problem.  I will provide you with any further
information needed or send you a full kernel startup log if wanted.


What I tried:

The problem occurs at the end of any shut-down process, right when
the system should reboot (or power off).  I tried different Kernel
versions (form 3.6.test6 to 2.6.4) using different compiler
tool-chains and configurations.  It also tried a kernel 2.6.1 from a
"Knoppix" CD distribution, so this is unrelated to my compiler.

I tried booting into single user and rebooting via sysreq-keys, it
made the machine hang, too -- so I would say the userland is not
involved.

During digging in the dark I also tried different power-management
configurations with APM and ACPI, no chance (normally I use APM).

This is only a 2.6.x matter, all earlier Kernels I used (including
some 2.2.x versions and nearly every 2.4.x version), the netbsd
kernel (1.6.1 and 1.6.2) and the grub bootloader are able to reboot
the system as expected.


This problem is 100% reproducible on my box, but I haven't yet found
any other system showing this symptoms.

Sorry for this very vague report, but I have simply no idea, what
might be the cause.

Please CC me in any answers, I'm not subscribed to the lkml.

cheers
sascha

ps. please don't mind my worse English.
-- 
Sascha Wilde
... mein Opa [...]  würde an dieser Stelle zu Dir sagen: Junge, such Dir 
ne Frau, bau Dir ein Haus, mach ein Kind und laß' die Finger von dem Zeug,
das Du gerade machst. -- Michael Winklhofer in d.a.e.auktionshaeuser
