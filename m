Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGQNzi>; Wed, 17 Jul 2002 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGQNzi>; Wed, 17 Jul 2002 09:55:38 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:27342 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S314514AbSGQNz1>; Wed, 17 Jul 2002 09:55:27 -0400
Date: Wed, 17 Jul 2002 15:58:23 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717135823.GG14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717154448.A19761@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 03:44:48PM +0200, Vojtech Pavlik wrote:

> Try this patch, 

It doesn't change anything:
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
i8042.c: fa <- i8042 (flush, kbd) [0]
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [0]
i8042.c: 5a -> i8042 (parameter) [0]
i8042.c: a5 <- i8042 (return) [0]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 76 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 56 <- i8042 (return) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 54 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 56 -> i8042 (parameter) [2]
i8042.c: d4 -> i8042 (command) [2]
i8042.c: f6 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [3]
i8042.c: 56 -> i8042 (parameter) [3]
i8042.c: 60 -> i8042 (command) [92]
i8042.c: 54 -> i8042 (parameter) [92]
i8042.c: 60 -> i8042 (command) [93]
i8042.c: 56 -> i8042 (parameter) [93]
i8042.c: d4 -> i8042 (command) [93]
i8042.c: f5 -> i8042 (parameter) [93]
i8042.c: 60 -> i8042 (command) [93]
i8042.c: 56 -> i8042 (parameter) [93]
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 54 -> i8042 (parameter) [182]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 44 -> i8042 (parameter) [182]
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 45 -> i8042 (parameter) [182]
i8042.c: f6 -> i8042 (kbd-data) [182]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [185]
i8042.c: f2 -> i8042 (kbd-data) [185]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [188]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [194]
i8042.c: 60 -> i8042 (command) [194]
i8042.c: 44 -> i8042 (parameter) [194]
i8042.c: 60 -> i8042 (command) [194]
i8042.c: 45 -> i8042 (parameter) [194]
i8042.c: f5 -> i8042 (kbd-data) [194]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [197]
i8042.c: f2 -> i8042 (kbd-data) [197]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [200]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [205]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [210]
i8042.c: ea -> i8042 (kbd-data) [210]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [213]
i8042.c: f0 -> i8042 (kbd-data) [213]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [216]
i8042.c: 02 -> i8042 (kbd-data) [216]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [219]
i8042.c: f0 -> i8042 (kbd-data) [219]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [221]
i8042.c: 00 -> i8042 (kbd-data) [221]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [224]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [226]
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: f8 -> i8042 (kbd-data) [230]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [232]
i8042.c: ed -> i8042 (kbd-data) [233]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [236]
i8042.c: 00 -> i8042 (kbd-data) [236]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [242]
i8042.c: f4 -> i8042 (kbd-data) [242]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [245]
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
...

> if it doesn't work, we'll have to try more changes, like
> trying to skip the AUX port detection that might confuse the chip ....

I should enhance however that it works with the old pc_keyb driver.
I don't know the internals but it may give you a hint...

> Btw, what's the exact chipset involved?

It's a Sony VAIO Picturebook C1VE, lspci:
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
00:0b.0 Multimedia controller: Kawasaki Steel Corporation: Unknown device ff01 (rev 01)
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
00:0d.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
