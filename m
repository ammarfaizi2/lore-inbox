Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQJ1O3N>; Sat, 28 Oct 2000 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129934AbQJ1O3D>; Sat, 28 Oct 2000 10:29:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50958 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129678AbQJ1O2v>; Sat, 28 Oct 2000 10:28:51 -0400
Subject: Re: PLIP driver in 2.2.xx kernels
To: lnxkrnl@mail.ludost.net
Date: Sat, 28 Oct 2000 15:30:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010281859580.3112-100000@doom.izba.net> from "lnxkrnl@mail.ludost.net" at Oct 28, 2000 07:04:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pWzo-0005MJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I have a question - Why does the PLIP driver does consume so much CPU ?
> I tried it today, and when i did ping -s 16000 dst_ip, the kernel consumed
> about 50% of the CPU time ( /proc/cpuinfo and /proc/interrupts follow).
> Any ideas ?

It has to bang on the parallel port controller the hard way, there is no
useful hardware support on a basic parallel port for the kind of abuse needed
for PLIP
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
