Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRB0NCS>; Tue, 27 Feb 2001 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRB0NCI>; Tue, 27 Feb 2001 08:02:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44557 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129175AbRB0NCA>; Tue, 27 Feb 2001 08:02:00 -0500
Subject: Re: Linux 2.4.2 DMA Interrupt poblem?
To: jsidhu@arraycomm.com (Jasmeet Sidhu)
Date: Tue, 27 Feb 2001 13:05:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <5.0.2.1.2.20010226170434.026a7d68@pop.arraycomm.com> from "Jasmeet Sidhu" at Feb 26, 2001 05:07:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Xjoe-0003N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb 24 14:00:52 bertha kernel: hdi: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 24 14:00:52 bertha kernel: hdi: dma_intr: error=0x40 { 
> UncorrectableError }, LBAsect=42484802, sector=42484720

Uncorrectable generally implies a hardware failure such as a bad block on
the disk


