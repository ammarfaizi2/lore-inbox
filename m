Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSIJUsV>; Tue, 10 Sep 2002 16:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIJUsV>; Tue, 10 Sep 2002 16:48:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52213 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318101AbSIJUsV>; Tue, 10 Sep 2002 16:48:21 -0400
Date: Tue, 10 Sep 2002 22:53:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] add "If unsure, say N" to CONFIG_X86_TSC_DISABLE
Message-ID: <Pine.NEB.4.44.0209102247150.18902-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below does:
- add a "If unsure, say N" to CONFIG_X86_TSC_DISABLE
- fix two typos

cu
Adrian


--- Documentation/Configure.help.old	2002-09-10 22:38:42.000000000 +0200
+++ Documentation/Configure.help	2002-09-10 22:49:21.000000000 +0200
@@ -240,9 +240,11 @@
   which processor you have compiled for.

   NOTE: If your system hangs when init should run, you are probably
-  using a i686 compiled glibc which reads the TSC wihout checking for
-  avaliability. Boot without "notsc" and install a i386 compiled glibc
+  using a i686 compiled glibc which reads the TSC without checking for
+  availability. Boot without "notsc" and install a i386 compiled glibc
   to solve the problem.
+
+  If unsure, say N.

 Multiquad support for NUMA systems
 CONFIG_MULTIQUAD


