Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTKLDBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTKLDBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:01:05 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:30156 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S261586AbTKLDBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:01:01 -0500
Message-ID: <1068602198.3fb193567bcc7@horde.sandall.us>
Date: Tue, 11 Nov 2003 17:56:38 -0800
From: Eric Sandall <eric@sandall.us>
To: otto.wyss@orpatec.ch
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: USB-keyboard not recognized when not connected during startup
References: <3FAFDA82.864DC1BE@orpatec.ch>
In-Reply-To: <3FAFDA82.864DC1BE@orpatec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Otto Wyss <otto.wyss@orpatec.ch>:
> Please CC, I'm not subscribed.
> 
> I use an USB-keyboard via an USB-switchbox on 2 computers (PC and Mac).
> When I boot into Windows or MacOS9 it doesn't matter whether my USB is
> connected, the keyboard gets recognized when the connection happens. Not
> so on Linux (PC), there the keyboard gets only recognized if it's
> connected during startup. If I forget to switch the keyboard to the PC
> before I start Linux, it isn't recognized and unusable. This is mostly
> annoying because I can't get rid of my AT-keyboard and just use the
> USB-keyboard, a none working keyboard is identical to a system crash!
> When the USB-keyboard is connected during startup everything is okay.
> 
> I've seen this behavior with my Debian (sarge) system running my own
> built kernel 2.4.21 with USB input and keyboard drivers compiled in. I
> also see this problem when running Knoppix live CD, therefore it's
> common to any Debian based system, probably to any Linux system.
> 
> Is this problem, not recognizing an USB-keyboard when not connected
> during startup, know and is there a solution for it? Is there a solution
> in the upcoming 2.6 kernel? 
> 
> If anyone wants to test this and has a desktop system with USB, just
> disconnect your normal keyboard, start the system and connect an
> USB-keyboard after the login prompt is shown. You could use the keyboard
> of a Mac if you don't have any. Also your kernel has to have
> USB-input/USB-HID and USB-keyboard support compiled in.
> 
> O. Wyss

Have you tried installing hotplug? That should automatically load the
modules/devices needed when you plug it in after boot.

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
