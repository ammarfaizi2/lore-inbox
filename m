Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136337AbRARXd6>; Thu, 18 Jan 2001 18:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136338AbRARXds>; Thu, 18 Jan 2001 18:33:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21004 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S136337AbRARXdj>; Thu, 18 Jan 2001 18:33:39 -0500
Date: Thu, 18 Jan 2001 14:16:56 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: more via-rhine problems.
Message-ID: <Pine.LNX.4.31.0101181343550.824-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5 mharris@asdf:~$ eth1: Transmit timed out, status 0000, PHY
status 0000, resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...


Nonstop..  argh.

I now believe that it is indeed caused by booting to windows 98
(by accident).  ;o)

Doesn't matter if a driver is installed in win or not as I've
tried both.  Just booting win at all causes the card to go
berzerk next boot.  Must be something missing from the card init
code that should be resetting something on the card at init time,
but which is set by default on power on.

Very irritating.  Problem doesn't manifest itself until you
actually use the ethernet card for something.  Then you have to
log out of 17 vc's and 10 bugzilla windows in mozilla to reboot.

Disconcerting. ;o)

2.2.18 + Becker via-rhine




----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
If it weren't for C, we'd all be programming in BASI and OBOL.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
