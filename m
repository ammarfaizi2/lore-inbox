Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUABG0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 01:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbUABG0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 01:26:40 -0500
Received: from [66.62.77.7] ([66.62.77.7]:6126 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265059AbUABG0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 01:26:39 -0500
Subject: Synaptics 3button emulation hosed in 2.6.0-mm2
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
Cc: dtor_core@ameritech.net
Content-Type: text/plain
Message-Id: <1073024655.2516.11.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jan 2004 23:24:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brief summary: 3 button emulation very flaky
Linux: Fedora with 2.6.0-mm2
Laptop: Dell Inspiron 4150

----------------------------
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 27
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
input: PS/2 Generic Mouse on synaptics-pt/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
-----------------------------

When I highlight text and go to paste it by pressing both buttons at the
same time it only works 10% of the time. The majority of the time it
fails (don't paste anything).

When it fails, if I immediately press just the left mouse button about
1/2 the time it will paste.

I don't know if this is recent or not as I just recently started using
2.6 full time and I haven't used all the revisions.

Dax Kelson

