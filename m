Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVKQVXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVKQVXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKQVXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:23:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27562 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751154AbVKQVXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:23:34 -0500
Date: Thu, 17 Nov 2005 22:23:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
In-Reply-To: <20051110191244.GG9488@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0511172221580.4792@yvahk01.tjqt.qr>
References: <XFMail.20051102104916.pochini@shiny.it>
 <Pine.LNX.4.61.0511102002160.17092@yvahk01.tjqt.qr> <20051110191244.GG9488@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1481410914-1132262601=:4792"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1481410914-1132262601=:4792
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



Building for VMware Workstation 5.0.0.
Using 2.6.x kernel build system.
make -C /lib/modules/2.6.13-AS20/build/include/.. SUBDIRS=$PWD 
SRCROOT=$PWD/. modules
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/linux/driver.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/linux/hostif.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/cpuid.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/hash.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/memtrack.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/phystrack.o
  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/task.o
cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
Ada/C/ObjC but not for C++
cc1plus: warning: command line option 
"-Werror-implicit-function-declaration" is valid for C/ObjC but not for C++
cc1plus: warning: command line option "-Wdeclaration-after-statement" is 
valid for C/ObjC but not for C++
cc1plus: warning: command line option "-Wno-pointer-sign" is valid for 
C/ObjC but not for C++
cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
Ada/C/ObjC but not for C++
cc1plus: warning: command line option "-ffreestanding" is valid for C/ObjC 
but not for C++
include/asm/bitops.h: In function ■int find_first_bit(const long unsigned 
int*,
unsigned int)■:
include/asm/bitops.h:334: warning: comparison between signed and unsigned 
integer expressions
[...]



>> It does, to a limited degree. Just look at the VMware vmmon/vmnet driver 
>> sources.
>
>At least version 4.5.2 appears to be entirely c code to me.  What looks
>like c++ to you in there?


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
--1283855629-1481410914-1132262601=:4792--
