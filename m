Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTKJSfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTKJSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:35:54 -0500
Received: from mail.xor.ch ([212.55.210.163]:8969 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S264022AbTKJSfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:35:52 -0500
Message-ID: <3FAFDA82.864DC1BE@orpatec.ch>
Date: Mon, 10 Nov 2003 19:35:47 +0100
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: USB-keyboard not recognized when not connected during startup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC, I'm not subscribed.

I use an USB-keyboard via an USB-switchbox on 2 computers (PC and Mac).
When I boot into Windows or MacOS9 it doesn't matter whether my USB is
connected, the keyboard gets recognized when the connection happens. Not
so on Linux (PC), there the keyboard gets only recognized if it's
connected during startup. If I forget to switch the keyboard to the PC
before I start Linux, it isn't recognized and unusable. This is mostly
annoying because I can't get rid of my AT-keyboard and just use the
USB-keyboard, a none working keyboard is identical to a system crash!
When the USB-keyboard is connected during startup everything is okay.

I've seen this behavior with my Debian (sarge) system running my own
built kernel 2.4.21 with USB input and keyboard drivers compiled in. I
also see this problem when running Knoppix live CD, therefore it's
common to any Debian based system, probably to any Linux system.

Is this problem, not recognizing an USB-keyboard when not connected
during startup, know and is there a solution for it? Is there a solution
in the upcoming 2.6 kernel? 

If anyone wants to test this and has a desktop system with USB, just
disconnect your normal keyboard, start the system and connect an
USB-keyboard after the login prompt is shown. You could use the keyboard
of a Mac if you don't have any. Also your kernel has to have
USB-input/USB-HID and USB-keyboard support compiled in.

O. Wyss

-- 
See "http://wxguide.sourceforge.net/" for ideas how to design your app
