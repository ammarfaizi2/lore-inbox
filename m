Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTBTI0W>; Thu, 20 Feb 2003 03:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTBTI0W>; Thu, 20 Feb 2003 03:26:22 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:61076 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264940AbTBTI0V>; Thu, 20 Feb 2003 03:26:21 -0500
Message-ID: <20030220083620.31336.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 16:36:20 +0800
Subject: No sound
X-Originating-Ip: 62.101.98.215
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I really don't know the version of a kernel that played sound (in the 2.5 serie).

dmesg from 2.5.61:
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sun Feb 09 18:00:12 2003 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
no UART detected at 0xffff
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: 
  #3: ESS Maestro3 PCI at 0x1800, irq 5 <- My sound card ;-)

And from 2.5.62:
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
no UART detected at 0xffff
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: 
  #3: ESS Maestro3 PCI at 0x1800, irq 5

Quite different from the previous one.

Both of them doesn't play any sound.

Any hint/suggestion ?

Ciao,
             Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
