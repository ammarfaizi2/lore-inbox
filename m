Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJREkI>; Fri, 18 Oct 2002 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJREjZ>; Fri, 18 Oct 2002 00:39:25 -0400
Received: from web10508.mail.yahoo.com ([216.136.130.158]:43165 "HELO
	web10508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262914AbSJREiC>; Fri, 18 Oct 2002 00:38:02 -0400
Message-ID: <20021018044402.42069.qmail@web10508.mail.yahoo.com>
Date: Thu, 17 Oct 2002 21:44:02 -0700 (PDT)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am having problem with the (ethernet) Tigon3
driver with Linux kernel 2.4.20-pre10-ac2.  If a
program busily sends packets out on a raw socket
(PF_PACKET, SOCK_RAW) on a Tigon3-chipset-based
ethernet card (Neargear GA302T), the machine (AMD
Athlon CPU, KT333 motherboard) locks up hard after a
while.  No kernel panic or other error messages.  If I
use a Intel PRO1000 card with the e1000 driver and
identical same hardware and program otherwise, no lock
up problem and the packets are sent properly.  Thus
this indicates the problem is in the Tigon3 driver.

Thanks for any info on solving this problem.

 

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
