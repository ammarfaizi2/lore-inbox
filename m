Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSKYWWl>; Mon, 25 Nov 2002 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSKYWWl>; Mon, 25 Nov 2002 17:22:41 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:48901 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265752AbSKYWWj>; Mon, 25 Nov 2002 17:22:39 -0500
Message-ID: <20021125222949.5336.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Date: Tue, 26 Nov 2002 06:29:49 +0800
Subject: oops at boot with 2.5.49-mm1
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/all
I'm not able to boot kernel 2.5.49-mm1

[...]
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
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
specify port
PCI: Found IRQ 5 for device 00:0d.0
< More or less the system oops here >
< More or less the system oops here >
< More or less the system oops here >
< More or less the system oops here >
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: 
  #3: ESS Maestro3 PCI at 0x1800, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)

The machine oops and I can see the following sentence:
DEBUG: sleeping function called from illegal context at include/linux/rwsem.h:43

Does it help?

Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
