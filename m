Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318261AbSGQKHM>; Wed, 17 Jul 2002 06:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSGQKHL>; Wed, 17 Jul 2002 06:07:11 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:1443 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318261AbSGQKHK>; Wed, 17 Jul 2002 06:07:10 -0400
Date: Wed, 17 Jul 2002 12:10:01 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717101001.GE14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717120135.A12452@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 12:01:35PM +0200, Vojtech Pavlik wrote:

> > Should I enable some extra debug somewhere ?
> 
> Yes, please, in drivers/input/serio/i8042.h

Here it comes:

...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
i8042.c: fa <- i8042 (flush) [0]
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 57 -> i8042 (parameter) [0]
i8042.c: f6 -> i8042 (kbd-data) [1]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [3]
i8042.c: f2 -> i8042 (kbd-data) [4]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [6]
i8042.c: ab <- i8042 (interrupt-kbd, 1) [12]
i8042.c: 60 -> i8042 (command) [12]
i8042.c: 56 -> i8042 (parameter) [12]
i8042.c: 60 -> i8042 (command) [12]
i8042.c: 57 -> i8042 (parameter) [12]
i8042.c: f5 -> i8042 (kbd-data) [12]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [15]
i8042.c: f2 -> i8042 (kbd-data) [15]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [18]
i8042.c: ab <- i8042 (interrupt-kbd, 1) [23]
i8042.c: 41 <- i8042 (interrupt-kbd, 1) [29]
i8042.c: ea -> i8042 (kbd-data) [29]
i8042.c: fe <- i8042 (interrupt-kbd, 1) [31]
i8042.c: f0 -> i8042 (kbd-data) [31]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [34]
i8042.c: 02 -> i8042 (kbd-data) [34]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [37]
i8042.c: f0 -> i8042 (kbd-data) [37]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [40]
i8042.c: 00 -> i8042 (kbd-data) [40]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [43]
i8042.c: 41 <- i8042 (interrupt-kbd, 1) [45]
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: f8 -> i8042 (kbd-data) [48]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [51]
i8042.c: ed -> i8042 (kbd-data) [51]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [54]
i8042.c: 00 -> i8042 (kbd-data) [55]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [60]
i8042.c: f4 -> i8042 (kbd-data) [60]
i8042.c: fa <- i8042 (interrupt-kbd, 1) [63]
serio: i8042 KBD port at 0x60,0x64 irq 1
i8042.c: d3 -> i8042 (command) [63]
i8042.c: 5a -> i8042 (parameter) [63]
i8042.c: a5 <- i8042 (return) [63]
i8042.c: a9 -> i8042 (command) [63]
i8042.c: 00 <- i8042 (return) [63]
i8042.c: a7 -> i8042 (command) [63]
i8042.c: 20 -> i8042 (command) [64]
i8042.c: 67 <- i8042 (return) [64]
i8042.c: a9 -> i8042 (command) [64]
i8042.c: 00 <- i8042 (return) [64]
i8042.c: a8 -> i8042 (command) [64]
i8042.c: 20 -> i8042 (command) [64]
i8042.c: 47 <- i8042 (return) [64]
i8042.c: 60 -> i8042 (command) [64]
i8042.c: 75 -> i8042 (parameter) [64]
i8042.c: 60 -> i8042 (command) [65]
i8042.c: 77 -> i8042 (parameter) [65]
i8042.c: d4 -> i8042 (command) [65]
i8042.c: f6 -> i8042 (parameter) [65]
i8042.c: 60 -> i8042 (command) [66]
i8042.c: 77 -> i8042 (parameter) [66]
i8042.c: 60 -> i8042 (command) [153]
i8042.c: 75 -> i8042 (parameter) [153]
i8042.c: 60 -> i8042 (command) [153]
i8042.c: 77 -> i8042 (parameter) [153]
i8042.c: d4 -> i8042 (command) [153]
i8042.c: f5 -> i8042 (parameter) [153]
i8042.c: 60 -> i8042 (command) [154]
i8042.c: 77 -> i8042 (parameter) [154]
i8042.c: 60 -> i8042 (command) [241]
i8042.c: 75 -> i8042 (parameter) [241]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [242]
i8042.c: 45 -> i8042 (parameter) [242]
NET4: Linux TCP/IP 1.0 for NET4.0
...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
