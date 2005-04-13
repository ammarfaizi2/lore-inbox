Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVDMPeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDMPeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVDMPeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:34:14 -0400
Received: from pop.gmx.de ([213.165.64.20]:30442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261368AbVDMPeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:34:06 -0400
X-Authenticated: #26515711
Message-ID: <425D75AF.7080802@gmx.de>
Date: Wed, 13 Apr 2005 21:40:31 +0200
From: Oliver Korpilla <Oliver.Korpilla@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050118)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: debian-kernel@lists.debian.org, debian-toolchain@lists.debian.org,
       linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Crosspost] GNU/Linux userland?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I wondered if there is a project or setup that does allow me to build a 
GNU/Linux userland including kernel, build environment, basic tools with 
a single script just as you can in NetBSD (build.sh) or FreeBSD (make 
world).

I do not refer to a step-by-step instruction like "Linux From Scratch" 
(which I do find commendable, but is not quite the same), but an 
automated, cross-compilation aware foundation for a Linux system.

I found one of the great things about NetBSD which I miss in Linux that 
I can generate a baseline from source that quickly. It would mix greatly 
with the package management systems for Linux, like apt or rpm, which 
could be used for all other stuff, like X11.

I'd say such a system should include (not complete, just in my opinion):
* Kernel 2.6.x
* Sample generic kernel configurations (like GENERIC etc. in NetBSD)
* GNU Toolchain (gcc, gdb, glibc, ...)
* GNU make
* udev-Support oder eine /dev-Generierungsskript
* Bash
* basic networking tools
* an interpreter for the language the build script is in (Sh, Python, ...)
* Security (PAM support, Shadow passwords)
* System V init

It should contain anything you need to build a baseline from within the 
baseline.
It should be a minimal setup.
It should include cross-compilation support.

It would be imaginable to have similar scripts to create embedded 
development host setup (toolchains and libs) and an embedded development 
target baseline (uclibc, other libraries, busybox).

Is there something that at least partly is in that direction?
Is there a need for something like this?

I'm asking out of genuine curiosity, and hoping for answers.

Please CC me, I'm in none of these lists!

Thanks and with kind regard,
Oliver Korpilla
