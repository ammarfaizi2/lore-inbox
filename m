Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRG3IfV>; Mon, 30 Jul 2001 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbRG3IfK>; Mon, 30 Jul 2001 04:35:10 -0400
Received: from ns.axept.org ([212.23.245.98]:12389 "EHLO axpzrh-mf02.axept.ch")
	by vger.kernel.org with ESMTP id <S268071AbRG3Iet>;
	Mon, 30 Jul 2001 04:34:49 -0400
Message-ID: <3D2C2236F3C9194B8328E3375C3ABFDA334E7C@axpzrh-mf01.axept.ch>
From: Morger Philipp <Philipp.Morger@axept.ch>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel >2.4.2 - network - eepro100
Date: Mon, 30 Jul 2001 10:34:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Kernel Hackers

I Just swiched from my Compaq E700 to a Dell Inspiron 2500... everything
works fine, it's a great pleasure to see how fast Linux assimilates the new
Notebook... but one thing is strange...

On my "old" Notebook I had Kernel 2.4.6... I ghostet (that's an old DOS
Disk-cloning tool, just in case you don't know..) the whole maschine; after
I restored the Lilo bootrecord, the maschine bootet as it were the old....
except sound, X11 and network... and the network problem appears only when I
boot with a kernel-version higher than 2.4.2. Either there's something wrong
with the network driver or some other driver who manages the chipset (Camino
2), or gcc... 

I have an up-to-date unstable debian linux... so that things break is
nothing new... just thought, that this one might be a kernel problem;
unfortunately I'm not able to build a 2.4.2 kernel anymore... (just have my
non-modules based 2.4.2-BACKUP kernel)... it also might be an gcc problem...
I don't know, just wantet to let you know of that. If you have any advice on
how to solve the problem, or if you need any further information, please let
me know (full dmesg, kernel config file... whatever...)

Kernel 2.4.2
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:E0:68:76:CE, IRQ 5.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 727095-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.

Kernel 2.4.7
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: Invalid EEPROM checksum 0xff00, check settings before activating this
device!
eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 5.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip iunknown-15 PHY #31
     Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).

Thanks
Philipp Morger
