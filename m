Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311286AbSCLQ5S>; Tue, 12 Mar 2002 11:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311289AbSCLQ5I>; Tue, 12 Mar 2002 11:57:08 -0500
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:30681 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S311286AbSCLQ4v>; Tue, 12 Mar 2002 11:56:51 -0500
From: jarausch@igpm.rwth-aachen.de
Message-Id: <200203121656.RAA43598@numa1.igpm.rwth-aachen.de>
Date: Tue, 12 Mar 2002 17:56:40 +0100
Reply-To: jarausch@igpm.rwth-aachen.de
Subject: 2.4.19-pre3 IDE-problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

on my Supermicro Serverworks board
with ide-scsi emulation 2.4.19-pre3 hangs
when accessing the IDE-ZIP drive (at Serverworks IDE)
(2.4.18 with the IDE is OK)

Although I configured DMA for disks only
I get
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdd: lost interrupt  (that is a new ATA 133 Maxtor disk at a Promise IDE
controler)

Serverworks OSB4 in impossible state
Disable UDMA ....

(I have already applied the bluesmoke patch posted)

Thanks for looking into it

Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
Institute of Technology, RWTH Aachen
D 52056 Aachen, Germany

