Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCREYr>; Sat, 17 Mar 2001 23:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRCREYi>; Sat, 17 Mar 2001 23:24:38 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:32444 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129460AbRCREY1>;
	Sat, 17 Mar 2001 23:24:27 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103180423.UAA17766@csl.Stanford.EDU>
Subject: [CHECKER] blocking w/ spinlock or interrupt's disabled
To: linux-kernel@vger.kernel.org
Date: Sat, 17 Mar 2001 20:23:34 -0800 (PST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> called with either interrupts disabled or a spin lock held.  The
> checker works by: 

Here's the file manifest.  Apologies.

drivers/atm/idt77105.c
drivers/atm/iphase.c
drivers/atm/uPD98402.c
drivers/block/cciss.c
drivers/block/cpqarray.c
drivers/char/applicom.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/n_r3964.c
drivers/char/rio/rioctrl.c
drivers/char/rio/riotable.c
drivers/char/rio/riotty.c
drivers/char/riscom8.c
drivers/char/serial.c
drivers/char/specialix.c
drivers/i2o/i2o_proc.c
drivers/ide/ide-probe.c
drivers/ide/umc8672.c
drivers/isdn/act2000/act2000_isa.c
drivers/isdn/hisax/gazel.c
drivers/isdn/icn/icn.c
drivers/isdn/isdnloop/isdnloop.c
drivers/md/raid1.c
drivers/net/aironet4500_core.c
drivers/net/depca.c
drivers/net/irda/irport.c
drivers/net/irda/irtty.c
drivers/net/irda/smc-ircc.c
drivers/net/pcmcia/netwave_cs.c
drivers/net/ppp_generic.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx.c
drivers/net/wan/lmc/lmc_main.c
drivers/scsi/aha1542.c
drivers/scsi/atp870u.c
drivers/scsi/psi240i.c
drivers/scsi/sym53c416.c
drivers/scsi/tmscsim.c
drivers/sound/cmpci.c
drivers/sound/emu10k1/audio.c
drivers/sound/emu10k1/midi.c
drivers/sound/midibuf.c
drivers/sound/nm256_audio.c
drivers/sound/sb_ess.c
drivers/sound/sequencer.c
drivers/usb/serial/empeg.c
drivers/usb/serial/keyspan_pda.c
drivers/usb/serial/mct_u232.c
drivers/usb/serial/omninet.c
drivers/usb/serial/usbserial.c
fs/hfs/catalog.c
net/bridge/br_if.c
net/irda/ircomm/ircomm_tty.c
