Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUA0CmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUA0CmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:42:02 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:19192 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261875AbUA0Ck6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:40:58 -0500
Subject: Synaptics problems with kernel 2.6.x
From: Richard Kuryk <rkuryk@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075171320.25088.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 21:42:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried compiling two different kernel versions 2.6.1-mm5 and
2.6.2_rc1-love1 and both produce errors like:

Synaptics driver lost sync at byte X
psmouse.c: bad data from KBC - timeout
Synaptics driver resynced.

My machine is a :

Compaq presario 1692 - AMD k6-2 433mhz
ALi Corp. M1533 PCI to ISA Bridge

Output from dmesg:

Intel ISA PCIC probe: not found.
mice: PS/2 mouse device common for all mice
Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option.
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

I have been reading prior messages so I know there are issues with power
management and ACPI and I have tried them on/off it doesn't really
help.  I have also tried enabled the HPET Timer but I don't think my
machine has one.  So far I have not been able to use X windows without
the mouse jumping every time I try and use the pad.  2.6.1-mm5 produced
a tad better results but still unusable.

I hope I included all the important info, but if you need additional
details please let me know what you need.  Please CC me.

Thanks,

Rich

