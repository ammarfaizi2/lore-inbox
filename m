Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQKTSoB>; Mon, 20 Nov 2000 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbQKTSnv>; Mon, 20 Nov 2000 13:43:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59442 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129511AbQKTSni>; Mon, 20 Nov 2000 13:43:38 -0500
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
To: Benjamin.Monate@lri.fr
Date: Mon, 20 Nov 2000 18:13:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14873.26936.500547.975636@sun-demons> from "Benjamin Monate <Benjamin Monate" at Nov 20, 2000 07:11:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xvRr-0003u9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a lock of the PCI bus (as SCSI and NIC are still working). Only the
> timer interrupts and NMI seem to be stuck : can a driver cause
> something so "lowlevel" ?

Something stopping the timers on the APIC I guess. But quite what or how I
don't know

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
