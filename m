Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRHTMiB>; Mon, 20 Aug 2001 08:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269825AbRHTMhw>; Mon, 20 Aug 2001 08:37:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:11600 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S269770AbRHTMhf>;
	Mon, 20 Aug 2001 08:37:35 -0400
Date: Mon, 20 Aug 2001 14:46:02 +0200
From: Stefan Fleiter <stefan.fleiter@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820144602.A12334@shuttle.mothership.home.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010820105520.A22087@oisec.net> <E15YmR3-0005mb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15YmR3-0005mb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

On Mon, 20 Aug 2001 Alan Cox wrote:

> > > With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
> > > compile with APIC enabled and APIC on UP also enabled, it boots
> > > cleanly
> > 
> > I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> > the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> > i've been getting these errors since 2.4.3.
> 
> There is a known BIOS irq routing table problem with a large number of Intel
> BIOS boards with onboard adaptec controllers.

I have the same problem, but my Adaptec is _not_ onboard.

sf@shuttle:~$ uname -r
2.4.8-ac7

sf@shuttle:~$ dmesg
[..]
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 14 for device 00:0b.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM-PCCO  Model: DDRS-39130Y   !#  Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST34572W          Rev: 0784
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-12TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi0:0:0:0: Tagged Queuing enabled.  Depth 24
scsi0:0:1:0: Tagged Queuing enabled.  Depth 24

Greetings,
Stefan
