Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319243AbSHUXkC>; Wed, 21 Aug 2002 19:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319247AbSHUXkC>; Wed, 21 Aug 2002 19:40:02 -0400
Received: from codepoet.org ([166.70.99.138]:25565 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S319243AbSHUXkC>;
	Wed, 21 Aug 2002 19:40:02 -0400
Date: Wed, 21 Aug 2002 17:44:12 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
Message-ID: <20020821234411.GA26772@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208212025.g7LKPda15450@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208212025.g7LKPda15450@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 21, 2002 at 04:25:39PM -0400, Alan Cox wrote:
> IDE status
> 	Chasing two reports of strange ide-scsi crashes
> 	Still some Promise glitches - need to review merge carefully

Its doesn't understand that I indeed am using 80 pin cables for
the drives connected to my Promise 20267 controller.  Also, it would
be nice to clean up the formatting on the "80-pin cable" message to
keep it from wrapping.



Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 58
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
[-------snip-------]
hde: IC35L040AVER07-0, ATA DISK drive
ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66
operation.
         Switching to Ultra33 mode.
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
hdg: WDC WD1200BB-00CAA1, ATA DISK drive
ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66
operation.
         Switching to Ultra33 mode.
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
[-------snip-------]
hde: host protected area => 1
hde: setmax LBA 80418240, native  1992187
hde: 1992187 sectors (1020 MB) w/1916KiB Cache, CHS=1976/16/63, UDMA(33)
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(33)


 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
