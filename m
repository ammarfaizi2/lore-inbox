Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S317403AbSFMS1w>; Thu, 13 Jun 2002 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S317434AbSFMS1v>; Thu, 13 Jun 2002 14:27:51 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:39688 "HELO patternassociates.com") by vger.kernel.org with SMTP id <S317403AbSFMS1s>; Thu, 13 Jun 2002 14:27:48 -0400
Message-ID: <20020613182748.25939.qmail@patternassociates.com>
From: rico-linux-kernel@patternassociates.com
Subject: Re: Serverworks OSB4 in impossible state
To: dani@ngrt.de
Date: Thu, 13 Jun 102 13:27:48 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020613110130.897E0109F6@mail.medav.de> from "Daniela Engert" at Jun 13, 2 02:04:56 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for investing time on the logic analyser, Dani.  My experience
is slightly different.

I have several mainboards (Tyan S1867) with older chipsets from
ServerWorks (f.k.a. Reliance).  The IDE controller (OSB4 rev 0) is used
daily with ATAPI CDRW drives in UDMA(33) Mode.  System handles read/write
errors without problem.

The system will lock solid when both IDE channels are accessed,
and either one is using DMA.  Since I want DMA, I simply abandon the
secondary channel.

I have spare machines available for quack medical experiments.

Select boot-time info...

Linux version 2.4.17 (rico@pc2) (gcc version 2.95.3 20010315 (release)) #1 SMP Mon Dec 31 11:51:33 CST 2001
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcb0-0xfcb7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcb8-0xfcbf, BIOS settings: hdc:pio, hdd:pio
hda: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
