Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbSLFVbV>; Fri, 6 Dec 2002 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbSLFVbV>; Fri, 6 Dec 2002 16:31:21 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:1796
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267618AbSLFVbU>; Fri, 6 Dec 2002 16:31:20 -0500
Date: Fri, 6 Dec 2002 16:42:06 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM]: 2.5.50 w/ module-init-tools 0.9.1 and 0.8 - Invalid module
 format w/ NEWS patch - SOLVED
Message-ID: <Pine.LNX.4.44.0212061641320.806-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone mentioned to me about 'other' patches for 2.5.50

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/2.5.50-patches.bz2

Just applied these and removed the NEWS patch.

This fixed it :-)

Shawn.

On December 6, 2002 11:13 am, Shawn Starr wrote:
> After patching 2.5.50 with the patch from the NEWS file, and recompiling
> completely the kernel and modules I'm not able to load modules:
>
> file gameport.o:
> gameport.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not
> stripped
>
> insmod:
> Error inserting `./gameport.o': -1 Invalid module format
>
> modprobe:
> FATAL: Error inserting gameport (/lib/modules/2.5.50/kernel/gameport.o):
> Invalid module format
>
> This occurs with 0.8 and 0.9.1
>
> Any solutions? I really need module support because there are some PnP
> issues that I'm trying to help solve.
>
> Shawn.

