Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRCST6N>; Mon, 19 Mar 2001 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131490AbRCST6E>; Mon, 19 Mar 2001 14:58:04 -0500
Received: from tallinn.sydamekirurgia.ee ([193.40.6.9]:61968 "EHLO
	ns.linking.ee") by vger.kernel.org with ESMTP id <S131466AbRCST5u>;
	Mon, 19 Mar 2001 14:57:50 -0500
Date: Mon, 19 Mar 2001 21:56:54 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
Subject: True multihead, lots of crashes
Message-ID: <Pine.LNX.4.21.0103192142480.28482-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
DUAL-Celeron, 2.4.0, 
	ATI64 Rage pro AGP, 
	Matrox Millenium,
	Matrox Mystique,
	ATI Rage II+ PCI,
	normal keyboard
	USB keyboard,
	2x USB mouse.
	USB hub and USB hub in keyboard.

	1. Just plain Xfree 4.0.2  with xinerama works stable, just 
	gets killed by memory-hogging netscape.
	2. framebuffer leads to hardlock sometimes quite soon. whatever,
	ati or matrox. Looks like at VT switch. No way to debug,

	3. I have here second patched Xfree, got someones patch and
	rebuilt rpm, to support USB keyboard. the box crashes also without
	it.
	It looks like all places where VT switch may occur, are commented
	out from xfree. 
	Without framebuffer, everything works, but vt switch
	still occurs and only one X is usable... 
	first X stalls until second gets killed and then works again.
	sometimes I can even switch between them from console.
	Does the console input trigger console switch... dont understand.
	strace doesnt show anything ... looks like two copies of X talk
	each other via shared memory or something...
		
elmer.





