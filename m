Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbTIQMW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTIQMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:22:29 -0400
Received: from 184.80-202-92.nextgentel.com ([80.202.92.184]:29561 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262704AbTIQMWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:22:21 -0400
Subject: Problems with Synaptics touchpad on Compaq Evo N600c and
	2.6.0-test5
From: Kjartan Maraas <kmaraas@broadpark.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063801250.3638.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 14:20:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried booting this kernel from http://people.redhat.com/arjanv/2.5/
and lost my mouse completely. Here's a snippet from /var/log/messages

Sep 17 12:45:13 localhost kernel: mice: PS/2 mouse device common for all
mice
Sep 17 12:45:13 localhost kernel: i8042.c: Detected active multiplexing
controller, rev 1.1.
Sep 17 12:45:13 localhost kernel: serio: i8042 AUX0 port at 0x60,0x64
irq 12
Sep 17 12:45:13 localhost kernel: serio: i8042 AUX1 port at 0x60,0x64
irq 12
Sep 17 12:45:13 localhost kernel: serio: i8042 AUX2 port at 0x60,0x64
irq 12
Sep 17 12:45:13 localhost kernel: synaptics reset failed
Sep 17 12:45:13 localhost last message repeated 2 times
Sep 17 12:45:13 localhost kernel: Synaptics Touchpad, model: 1
Sep 17 12:45:13 localhost kernel:  Firware: 5.8
Sep 17 12:45:13 localhost kernel:  180 degree mounted touchpad
Sep 17 12:45:13 localhost kernel:  Sensor: 27
Sep 17 12:45:13 localhost kernel:  new absolute packet format
Sep 17 12:45:13 localhost kernel:  Touchpad has extended capability bits
Sep 17 12:45:13 localhost kernel:  -> multifinger detection
Sep 17 12:45:13 localhost kernel:  -> palm detection
Sep 17 12:45:13 localhost kernel: input: Synaptics Synaptics TouchPad on
isa0060/serio4

I've been testing with the XFree86 packages from rawhide, updated as of
today, and the mouse works ok with the 2.4.x kernel from the same place.

I've got the latest BIOS for this laptop if that matters.

Cheers
Kjartan

