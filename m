Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbTDAJZZ>; Tue, 1 Apr 2003 04:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTDAJZZ>; Tue, 1 Apr 2003 04:25:25 -0500
Received: from vhe-530008.sshn.net ([195.169.222.38]:55168 "EHLO
	elektron.atoom.net") by vger.kernel.org with ESMTP
	id <S262215AbTDAJZY>; Tue, 1 Apr 2003 04:25:24 -0500
Date: Tue, 1 Apr 2003 11:36:46 +0200
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre6 and usb-uhci
Message-ID: <20030401093646.GA11420@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[ i'm not subscribed, so please cc me on any follow ups]

with kernel 2.4.21-pre6 my usb mouse stopped working (actually all usb stuff
stopped working). It's a logitech optical mouse which worked perfectly under
-pre5. I'm using the usb-uhci module.  I get no failures are anything of that
kind. dmesg just says:

hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
and
mice: PS/2 mouse device common for all mice

On my laptop (same mouse, same usb controllor) I also get these problems. It looks
to me if usb-uhci is not loaded or something, on -pre5 I get
this from my logs:

usb-uhci.c: $Revision: 1.275 $ time 10:38:36 Apr  1 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:08.0
usb-uhci.c: USB UHCI at I/O 0xfca0, IRQ 9
usb-uhci.c: Detected 2 ports

on -pre6 there are no such lines. Do I have to something differently in
pre6? Btw, the usb-uhci drivers is compiled into the kernel.

grtz  Miek


--
:wq!
