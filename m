Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137049AbREKFvG>; Fri, 11 May 2001 01:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137054AbREKFu5>; Fri, 11 May 2001 01:50:57 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:54501 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S137049AbREKFun>;
	Fri, 11 May 2001 01:50:43 -0400
Message-ID: <XFMail.20010511075040.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 11 May 2001 07:50:40 +0200 (CEST)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: make menuconfig versus make xconfig, Kernel 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made an update from Kernel 2.2.19 to 2.4.4, and I made
a copy from the 2.2.19 .config file into the 2.4.4 directory.

After that, I was wondering about the following fact:

"make menuconfig" for kernel 2.4.4 showed (what seems to
be correct) for ATA/IDE the same kernel configuration, as it
was shown in 2.2.19, when using the 2.2.19 ".config".

But: 2.4.4 "make xconfig" using the 2.2.19 .config showed
a disabled ATA/IDE configuration.

Only after saving the 2.4.4 configuration produced by "make menuconfig",
then the configuration for ATA/IDE was correctly displayed by "make xconfig".

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

