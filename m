Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129153AbQKQPU2>; Fri, 17 Nov 2000 10:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129555AbQKQPUS>; Fri, 17 Nov 2000 10:20:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129153AbQKQPUG>; Fri, 17 Nov 2000 10:20:06 -0500
Subject: Re: Error in x86 CPU capabilities starting with test5/6
To: cr@sap.com (Christoph Rohland)
Date: Fri, 17 Nov 2000 14:50:33 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian), ak@suse.de (Andi Kleen),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        mikpe@csd.uu.se (Mikael Pettersson), ledzep37@home.com (Jordan),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <qwwsnoqu0vx.fsf@sap.com> from "Christoph Rohland" at Nov 17, 2000 03:30:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wmqZ-0000iq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I thought Linux kernel does synchronize them on boot? So, you are
> > saying I cannot rely on this being 100% correct?
> 
> Yes, it does so far. And if we cannot assume this to be correct in the
> microsecond scale on smp machines with homogenous non-powersaving cpus
> we will loose on some benchmarks. So far it works on all our servers.

It works on most machines. Nothing in the intel specifications says it works.
We cope with offset TSC's in the kernel and those are unusual but exist. If
you have two differently clocked cpus you have to boot notsc.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
