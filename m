Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUCNMMM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbUCNMML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:12:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21755 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263355AbUCNMMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:12:07 -0500
Date: Sun, 14 Mar 2004 13:12:05 +0100 (MET)
Message-Id: <200403141212.i2ECC5vo008463@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jo@sommrey.de, linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004 22:42:55 +0100, Joerg Sommrey wrote:
>in my box (Tyan Tiger MPX / 2x AMD Athlon) the NMI watchdog never worked
>on any kernel that I tried (2.4.x, 2.6.x). I always found:
>| activating NMI Watchdog ... done.
>| testing NMI watchdog ... CPU#0: NMI appears to be stuck!
>
>But there is one exception: 2.6.3-mm4 shows:
>| activating NMI Watchdog ... done.
>| testing NMI watchdog ... OK.
>
>[2.6.3-mm4 was the only -mmX kernel I tried so far.]
>
>With 2.6.4-mm1 the NMI watchdog is again not functional in my box. Any
>ideas?

Insufficient data. Please try a standard 2.6.4 or 2.4.25 kernel
and provide the complete dmesg boot log and the .config used.

nmi_watchdog=1 may be broken on some chipsets, but nmi_watchdog=2
should work, at least in a standard kernel with oprofile disabled.

/Mikael
