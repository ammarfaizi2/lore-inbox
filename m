Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282691AbRLLW20>; Wed, 12 Dec 2001 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282693AbRLLW2R>; Wed, 12 Dec 2001 17:28:17 -0500
Received: from ulima.unil.ch ([130.223.144.143]:1920 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S282691AbRLLW17>;
	Wed, 12 Dec 2001 17:27:59 -0500
Date: Wed, 12 Dec 2001 23:27:57 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: ECP parport, howto?
Message-ID: <20011212232757.A3687@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an asus P2B-ls with a parport that should be ECP (and that what I
set in BIOS), when I load the modules parport, parport_pc and ppdev:

parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
ppdev: user-space parallel port driver

Is there something special to do to obtain ECP capabilities (I need it
to run VMWARE which I would like to try...).

I have already tried to give it the dma 3 which is reserved for parport.
/proc/interrupts:

           CPU0       
  0:     586491          XT-PIC  timer
  1:      11301          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     390441          XT-PIC  aic7xxx, usb-uhci, saa7146(1)
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
 10:      12412          XT-PIC  eth0, bttv
 11:       3693          XT-PIC  EMU10K1
 12:      31486          XT-PIC  PS/2 Mouse
 14:    2608574          XT-PIC  ide0
 15:      67196          XT-PIC  ide1
NMI:          0 
LOC:     586430 
ERR:          0
MIS:          0

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
