Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSF0KwR>; Thu, 27 Jun 2002 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316782AbSF0KwQ>; Thu, 27 Jun 2002 06:52:16 -0400
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:21176 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S316777AbSF0KwP>; Thu, 27 Jun 2002 06:52:15 -0400
From: jarausch@igpm.rwth-aachen.de
Message-Id: <200206271052.MAA63674@numa1.igpm.rwth-aachen.de>
Date: Thu, 27 Jun 2002 12:52:09 +0200
Reply-To: jarausch@igpm.rwth-aachen.de
Subject: 2.4.19-rc1 still broken on Supermicro Serverworks
To: linux-kernel@vger.kernel.org
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

on 2.4.19-pre3 till 2.4.19-rc1 I get
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdd: lost interrupt  (that is the ZIP drive attached to the IDE bus)

Serverworks OSB4 in impossible state
Disable UDMA ....


Some time ago, Alan Cox replied
> There are a few wrinkles to iron out on the serverworks side yet.

Hopefully this happens before 2.4.19-final.

Many thanks,

Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
Institute of Technology, RWTH Aachen
D 52056 Aachen, Germany

