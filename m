Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbRGPG0r>; Mon, 16 Jul 2001 02:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbRGPG0h>; Mon, 16 Jul 2001 02:26:37 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:51720 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267209AbRGPG0c>; Mon, 16 Jul 2001 02:26:32 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Jul 2001 08:26:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.4: USB problem with disabled device
Message-ID: <3B52A524.28783.7B673@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a small problem: On my brother's PC with an Asus P2B and an non-PnP ISA 
SoundBlaster 16 there was a problem with sound not working any more:

His SB used IRQ 5 (hardwired) and he had disabled the USB device in 
BIOS. However SuSE Linux 7.2 detected the USB device and loaded the 
module. As it seemed, even though IRQ 5 was marked as reserved in BIOS, 
the disabled USB device also had IRQ 5. At least that's what the module 
allocated. Later the sound module complained about IRQ 5 not being 
available.

I have no idea what the effect of disabling a device in BIOS means to 
the hardware, or what can be done in the driver about it. I just wanted 
to let you know.

Ulrich
P.S. Not subscribed to linux-kernel...

