Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSECNnv>; Fri, 3 May 2002 09:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313089AbSECNnu>; Fri, 3 May 2002 09:43:50 -0400
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:10672 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S313012AbSECNns>; Fri, 3 May 2002 09:43:48 -0400
From: jarausch@igpm.rwth-aachen.de
Message-Id: <200205031343.PAA53310@numa1.igpm.rwth-aachen.de>
Date: Fri, 3 May 2002 15:43:37 +0200
Reply-To: jarausch@igpm.rwth-aachen.de
Subject: 2.4.19-pre8 IDE still broken
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

on my Supermicro Serverworks board
with an onboard Serverworks ide controller and
a Promise Ultra 133-TX2 ide controller

the kernel hangs when accessing an Iomega
Zip (Atapi) drive.
I've configured IDEDMA_ONLYDISK=y and
BLK_DEV_IDESCSI=y

This configuration works just fine with
a 2.4.18 kernel with the IDE-patches from
/pub/linux/kernel/people/hedrick/ide-2.4.18

on 2.4.19-pre3 till 2.4.19-pre8 I get
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdd: lost interrupt  (that is the ZIP drive)

Serverworks OSB4 in impossible state
Disable UDMA ....

If I disable UDMA, doesn't get my 24x CDwriter
slow? Does it affect the speed of my ATA133 harddisks on the
Promise controller?
Or do I need to buy a PCI-IDE-controller and disable
the onboard Serverworks IDE ?

Thanks for advice,

-- 
Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
Institute of Technology, RWTH Aachen
D 52056 Aachen, Germany

