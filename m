Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUJIU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUJIU7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUJIU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:59:48 -0400
Received: from [145.85.127.2] ([145.85.127.2]:21641 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267401AbUJIU7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:59:34 -0400
Message-ID: <56216.217.121.83.210.1097355563.squirrel@217.121.83.210>
In-Reply-To: <200410091348.09537.lkml@lpbproductions.com>
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210>
    <200410091315.10988.lkml@lpbproductions.com>
    <41684BC1.5000500@ppp0.net>
    <200410091348.09537.lkml@lpbproductions.com>
Date: Sat, 9 Oct 2004 22:59:23 +0200 (CEST)
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
From: "Ed Schouten" <ed@il.fontys.nl>
To: lkml@lpbproductions.com
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, October 9, 2004 10:48 pm, Matt Heler said:
> If it does go into mainline. What's to stop the inclusion of other gaming
> platforms into the kernel . Say for instance Playstation or Gamecube or
> some other variant.

Playstation 2 has an incomplete toolchain (I tried to compile Linux 2.4.26
with the Playstation 2 drivers, but it failed on a lot if MIPS ASM code).

The patch I made is 184KB (gzipped) and is available at:
http://www.il.fontys.nl/~ed/linux-2.4.26-ps2.diff.gz

So if anyone would like to develop it a little further, do your thing ;-)

Gamecube doesn't have a rootfs (only NFS and ramdisk), so I guess distro's
for that machine won't show up soon ;-)

Yours,
-- 
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
