Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUAFL4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 06:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAFL4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 06:56:06 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:44169 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S261929AbUAFL4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 06:56:04 -0500
Date: Tue, 6 Jan 2004 12:56:01 +0100
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0 / 2.6.1-rc2 problems with VT100 frames only on tty1
Message-ID: <20040106115601.GA19247@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!

I'm experiencing a really strange problems with all 2.6.x kernels (including
the latest 2.6.1-rc2). Using the links web browser both on PPC and x86 arch I
have ascii frames problems *only* on the first console.

tty2,tty3,tty4... frames are right with VT100 frames (and this was working on
                  2.4.x)
tty1              frames are right only with the 'Linux frames' option

Midnight Commander works fine on every console, I don't have other apps to
test this. This was caused migrating from 2.4.x to 2.6.x.

So why on 2.6.x the first terminal is not vt100 as inittab specify?

c1:12345:respawn:/sbin/agetty 38400 tty1 linux

I'm using framebuffer btw.

Bye and thanks

--
------------------------------------------------------------
INFIS Network Administrator & Security Officer         .*. 
Department of Physics       - University of Trieste     V 
lcars@infis.univ.trieste.it - GPG Key 0x864C9B9E      (   )
----------------------------------------------------  (   )
"How would you know I'm mad?" said Alice.             ^^-^^
"You must be,'said the Cat,'or you wouldn't have come here."
------------------------------------------------------------
