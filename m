Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUI3X0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUI3X0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbUI3X0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:26:17 -0400
Received: from smtp09.auna.com ([62.81.186.19]:56769 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269611AbUI3X0P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:26:15 -0400
Date: Thu, 30 Sep 2004 23:26:14 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm4
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
In-Reply-To: <20040926181021.2e1b3fe4.akpm@osdl.org> (from akpm@osdl.org on
	Mon Sep 27 03:10:21 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096586774l.5206l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.27, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/
> 
> - ppc64 builds are busted due to breakage in bk-pci.patch
> 
> - sparc64 builds are busted too.  Also due to pci problems.
> 
> - Various updates to various things.  In particular, a kswapd artifact which
>   could cause too much swapout was fixed.
> 
> - I shall be offline for most of this week.
> 

I have a 'little' problem. PS2 mouse is jerky as hell, an when you mismatch
the protocol in X. Both in console and X.
I'm lucky I have an usb mouse.

One other question. Isn't /dev/input/mice supposed to be a multiplexor
for mice ? I think I remember some time when I could have both a PS2 and
a USB mouse connected and X pointer followed both. Now if I boot with the
USB mouse plugged, the PS2 one does not work. If I boot with usb unplugged
and plug it after boot, both work; usb mouse works fine, and PS2 just
jumps half screen each time I move it, and with big delays.

Something is broken in PS2 handling ?

NOTE: they are not really standard protocol mice, but trackballs; PS2 one is
a Logitech TrackMan Marble FX, and the other a Cordless Trackman FX, usb.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


