Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDRJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTDRJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:02:59 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:21467 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S262982AbTDRJC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:02:56 -0400
Message-ID: <20030418091437.8621.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 18 Apr 2003 17:14:37 +0800
Subject: [ALSA] no sound with Maestro3
X-Originating-Ip: 62.101.98.215
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is 2.5.67,

Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20
13:31:57 
2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
no UART detected at 0xffff
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: 
  #2: ESS Maestro3 PCI at 0x1800, irq 5

Following my .config# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_DUMMY=y
# CONFIG_SND_VIRMIDI is not set
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y

#
# ISA devices
#
all are not set
#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_ES1938=y
CONFIG_SND_ES1968=y
CONFIG_SND_MAESTRO3=y
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

The result is that I haven't sound.

Bug 395 in bugzilla


Ciao,
         Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
