Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279324AbRJWJH5>; Tue, 23 Oct 2001 05:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279327AbRJWJHr>; Tue, 23 Oct 2001 05:07:47 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:2420 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S279324AbRJWJH2>; Tue, 23 Oct 2001 05:07:28 -0400
Message-ID: <3BD53362.72D5C74A@stud.uni-saarland.de>
Date: Tue, 23 Oct 2001 09:07:46 +0000
From: Manfred Spraul <masp0008@stud.uni-saarland.de>
Reply-To: manfred@colorfullife.com
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: Peter Putzer <pputzer@edu.uni-klu.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: FW: Via Rhine and Kernel 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need a few more details

> eth0: MII PHY found at address 1, status 0x782d advertising 01e1
> Link 00a1.

What is the link partner?
A dual speed hub?

Please add lspci -vxx and 

# via-diag -aa -mm -f

Run via-diag after ifup ethx

You can find via-diag at http://www.scyld.com/diag/index.html

> >  Tx scavenge 0 status 00008100.
> > eth0: Transmit error, Tx status 00008100.
> 
> This indicates that the transmit was aborted.  Presumably the
> transceiver was misconfigured.

Probably correct. I'll check the documentation.

--
	Manfred
