Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133078AbRDRLDU>; Wed, 18 Apr 2001 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133079AbRDRLDL>; Wed, 18 Apr 2001 07:03:11 -0400
Received: from mail.informatik.uni-ulm.de ([134.60.68.63]:12555 "EHLO
	mail.informatik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S133078AbRDRLC5>; Wed, 18 Apr 2001 07:02:57 -0400
Message-ID: <3ADD7445.6FD2068E@student.uni-ulm.de>
Date: Wed, 18 Apr 2001 13:02:29 +0200
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
Organization: University of Ulm
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: de,de-DE,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AHA-154X/1535 not recognized any more
In-Reply-To: <E14pbdW-000368-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > Now I have the problem that kernels 2.4.2 and 2.4.3 don't recognize this
> > adapter any more, while all 2.2-kernels I used (I currently remember
> > 2.2.19, 2.2.18 and debian-2.2.17pre6) work with it without problems.
> 
> Load the module with isapnp=1. It defaults to not scanning isapnp boards which
> strikes me as odd. Let me know if that fixes it if so I think I'll tweak the
> default

This gives me the following message:

lunix:/lib/modules/2.4.3# modprobe aha1542 isapnp=1
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o failed
/lib/modules/2.4.3/kernel/drivers/scsi/aha1542.o: insmod aha1542 failed

markus
-- 
Markus Schaber -- http://www.schabi.de/ -- ICQ: 22042130
+-------------------------------------------------------------+
| Allgemeine Sig-Verletzung 0815/4711  <nicht OK> <Erbrechen> |
+-------------------------------------------------------------+
