Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWANS4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWANS4d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWANS4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:56:33 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:2837 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750762AbWANS4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:56:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=bsEMHoNnv5mlPtKJ+VZ1vf8qrQU7J1erQwpTbKFKcjfnRiUkRzU6I/Gph1i5q3u057VKReVvDu6h8P3Imyg1UCnJ2E+pQa4O49vQobhbOlTWn/9JrMMRskyaPasM3pgqB7M9ukea1V4tkfgo518uZWvW7magcpJs9N6CL1tGKHI=
Message-ID: <43C9495C.6080200@gmail.com>
Date: Sat, 14 Jan 2006 19:56:28 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] README updated
Content-Type: multipart/mixed;
 boundary="------------040603070902090703050107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040603070902090703050107
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Replace old information with newer from kernel.org

-- 
Politicos de mierda, yo no soy un terrorista.

--------------040603070902090703050107
Content-Type: text/x-patch;
 name="README.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.diff"

diff -Nuar a/README b/README
--- a/README	2006-01-14 14:55:37.000000000 +0100
+++ b/README	2006-01-14 19:52:29.000000000 +0100
@@ -1,4 +1,4 @@
-	Linux kernel release 2.6.xx
+	Linux kernel release 2.6.xx <http://kernel.org>
 
 These are the release notes for Linux version 2.6.  Read them carefully,
 as they tell you what this is all about, explain how to install the
@@ -6,23 +6,31 @@
 
 WHAT IS LINUX?
 
-  Linux is a Unix clone written from scratch by Linus Torvalds with
-  assistance from a loosely-knit team of hackers across the Net.
-  It aims towards POSIX compliance. 
-
-  It has all the features you would expect in a modern fully-fledged
-  Unix, including true multitasking, virtual memory, shared libraries,
-  demand loading, shared copy-on-write executables, proper memory
-  management and TCP/IP networking. 
+  Linux is a clone of the operating system Unix, written from scratch by
+  Linus Torvalds with assistance from a loosely-knit team of hackers across
+  the Net. It aims towards POSIX and Single UNIX Specification compliance.
+
+  It has all the features you would expect in a modern fully-fledged Unix,
+  including true multitasking, virtual memory, shared libraries, demand
+  loading, shared copy-on-write executables, proper memory management,
+  and multistack networking including IPv4 and IPv6.
 
   It is distributed under the GNU General Public License - see the
   accompanying COPYING file for more details. 
 
 ON WHAT HARDWARE DOES IT RUN?
 
-  Linux was first developed for 386/486-based PCs.  These days it also
-  runs on ARMs, DEC Alphas, SUN Sparcs, M68000 machines (like Atari and
-  Amiga), MIPS and PowerPC, and others.
+  Although originally developed first for 32-bit x86-based PCs (386 or higher),
+  today Linux also runs on (at least) the Compaq Alpha AXP, Sun SPARC and
+  UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH,
+  IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64, AXIS CRIS,
+  and Renesas M32R architectures.
+
+  Linux is easily portable to most general-purpose 32- or 64-bit architectures
+  as long as they have a paged memory management unit (PMMU) and a port of the
+  GNU C compiler (gcc) (part of The GNU Compiler Collection, GCC). Linux has
+  also been ported to a number of architectures without a PMMU, although
+  functionality is then obviously somewhat limited.
 
 DOCUMENTATION:
 

--------------040603070902090703050107--
