Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbREPFqb>; Wed, 16 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbREPFqW>; Wed, 16 May 2001 01:46:22 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:34259 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S261794AbREPFqJ>;
	Wed, 16 May 2001 01:46:09 -0400
Message-ID: <XFMail.20010516074607.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 16 May 2001 07:46:07 +0200 (CEST)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: IRQ usage for PCI devices, Kernel 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sometimes the following messages appear in /var/log/messages:

        May 13 14:24:41 sunny kernel: PCI: Found IRQ 10 for device 00:0e.0
        May 13 14:24:41 sunny kernel: PCI: The same IRQ used for device 00:0a.0

"0e" is my PCI sound card, and "0a" is my PCI ethernet card. The messages apppear in
the following environment: I send from another linux machine (per ssh) a command
wich plays some sound on my sound card, therefore the eth0 event and the sound
event occur at almost the same time.

Question: Can I ignore these messages, or is there any buggy behaviour?

Regards


Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

