Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTK3VqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTK3VqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:46:18 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:10935 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264868AbTK3VqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:46:16 -0500
Date: Sun, 30 Nov 2003 22:46:12 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031130214612.GP2935@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I got a notebook with synaptics touch pad.

dmesg:
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

With Xfree I'm using synaptics driver. With 2.6.0-test11 cursor losts sync and
appers at random possition sometimes. 
I have in log:
Nov 30 12:32:23 debian kernel: Synaptics driver resynced.
Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 1st byte
Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 4th byte
Nov 30 12:33:54 debian kernel: Synaptics driver lost sync at 1st byte
Nov 30 12:33:54 debian last message repeated 2 times
Nov 30 12:33:54 debian kernel: Synaptics driver resynced.
Nov 30 12:34:25 debian kernel: Synaptics driver lost sync at 1st byte


It does not happen with 2.4.22 kernel. Is there something I can try?

-- 
Luká¹ Hejtmánek
