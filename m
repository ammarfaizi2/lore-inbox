Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274846AbRJAKHA>; Mon, 1 Oct 2001 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274845AbRJAKGu>; Mon, 1 Oct 2001 06:06:50 -0400
Received: from mail.siemens.pl ([217.153.88.106]:50702 "EHLO mail.siemens.pl")
	by vger.kernel.org with ESMTP id <S274838AbRJAKGk>;
	Mon, 1 Oct 2001 06:06:40 -0400
Message-ID: <F954B4B85128D4119FC000104BB868D502627C5A@wawzz11e.siemens.pl>
From: Piotr.Wadas@siemens.pl
To: linux-kernel@vger.kernel.org
Subject: UDMA question
Date: Mon, 1 Oct 2001 12:07:18 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello
kernel version: 2.4.9 / 2.4.10 and older versions too
I have ALI15x mainboard and when I enable in kernel configuration
an option for this chipset related to UDMA, it cannot properly detect
hard disks (it tries three times and then disables feature).
As long ALI15x chipset are known to be supported, it doesn't work for me :(

The disks are IDE, two 3GB WDC as /dev/hdb /dev/hdc and Quantum 10GB as hda
(I didn't turn on special no-crc access for WDB, although it's available in
kernel
with "Dangerous" mark)
Things gets messed when it starts "partition check" on hda, no matters if I
use
devfs or not.
does this feature work? maybe should I set some parameter like pio=xx or
sth?
I've done some research in this theme, but I didn't find anything like this.
Is there a possibility to enable/disable this chipset support from kernel
boot
commandline? some kind of udma=disable? maybe should I set PIO in BIOS?
do You guys know any quick solution for such problem?
best regards ;)
Piotrek (Piotr.Wadas@siemens.pl)
'an extreme linux fascinate'



