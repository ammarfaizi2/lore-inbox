Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUAJV2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUAJV2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:28:07 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:26343 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S265403AbUAJV2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:28:01 -0500
From: sven kissner <sven.kissner@consistencies.net>
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Jan 2004 22:30:41 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Subject: logitech cordless desktop deluxe optical keyboard issues
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401102230.54966.sven.kissner@consistencies.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello, 

i use the keyboard mentioned in the topic attached to the ps/2 keyboard port. 
most keys can be mapped using lineak or appropriate applications but i have 
problems getting some keys to work. i tested this with 2.6.0 and 2.6.1 as 
well as with some of the 2.4 series. with wintendo xp, all keys are working 
fine using logitech's itouch software.

xev is not displaying keycodes for the special keys not working but i get 
various messages by dmesg when pressing them:

<-- snip -->
atkbd.c: Unknown key pressed (translated set 2, code 0x91 on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x91 on isa0060/serio0).
atkbd.c: Unknown key pressed (translated set 2, code 0x92 on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x92 on isa0060/serio0).
<-- snap -->

on startup, i get the following:
with 2.6.x:
<-- snip -->
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
[..]
INIT: version 2.85
Loading /etc/console/boottime.kmap.gz
KDSKBENT: Invalid argument
failed to bind key 265 to value 638
KDSKBENT: Invalid argument
failed to bind key 265 to value 638
<-- snap -->

with 2.4.20 & 2.4.22-ck2 the value is increasing from 128 to 511, restarting 
~10 times(!):
<-- snip -->
INIT: version 2.85
Loading /etc/console/boottime.kmap.gz
KDSKBENT: Invalid argument
failed to bind key 128 to value 512
[..]
failed to bind key 511 to value 512
<-- snap -->

if i connect the kb to usb, there are slightly different issues, but let's do 
it step-by-step ;). any ideas how to get this working? if you require 
additional information, just let me know.

if answering, please put me on cc for i'm not subscribed to the list.

keep on rockin, 
sven
- --
..never argue with idiots. they drag you down to their level and beat you with 
experience..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAG8MPV/e7f4i4AERAm2aAKCXkcngzoaoVI0caZ9qCnzIx8qSxACdEJtx
VmFnQRAFUhCckPWPbf0PKD8=
=AaJH
-----END PGP SIGNATURE-----
