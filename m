Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137043AbREKEm1>; Fri, 11 May 2001 00:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137044AbREKEmQ>; Fri, 11 May 2001 00:42:16 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:29661 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S137043AbREKEmD>;
	Fri, 11 May 2001 00:42:03 -0400
Message-ID: <XFMail.20010511064201.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 11 May 2001 06:42:01 +0200 (CEST)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.4, Adaptec 7880 on board controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when booting on a machine having an Adaptec 7880 on board
controller (Kernel 2.4.4), then i get the following msg:

...
...

SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted

...
...

The aic7xxx scsi driver is not configured as module,
but linked to the kernel.

1. Despite of this messages, my kernel is running without
   any problem.

2. No such msg when using 2.2.x kernels

3. No such msg with kernel 2.4.4, when using an Adaptec 29xxx
   controler.

Any idea?

Regards


Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

