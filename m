Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSLTRPm>; Fri, 20 Dec 2002 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSLTRPm>; Fri, 20 Dec 2002 12:15:42 -0500
Received: from bgp926777bgs.brghtn01.mi.comcast.net ([68.41.8.22]:43911 "EHLO
	comcast.net") by vger.kernel.org with ESMTP id <S262875AbSLTRPj>;
	Fri, 20 Dec 2002 12:15:39 -0500
Date: Fri, 20 Dec 2002 12:24:26 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: axel@pearbough.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52: Many, many unresolved symbols!?
In-Reply-To: <20021220104644.GA637@neon.pearbough.net>
Message-ID: <Pine.LNX.4.50L0.0212201223390.1173-100000@dust.ebiz-gw.wintek.com>
References: <20021220104644.GA637@neon.pearbough.net>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002 axel@pearbough.net wrote:

> Hi,
> 
> after kernel build of 2.5.52-bk4 snapshot, depmod results in a very long
> list of unresolved symbols.
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.52bk4; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.52bk4/kernel/drivers/block/floppy.ko

Make sure you have the latest module-init-tools installed, and that 
/sbin/depmod points to the newest version of depmod from the 
module-init-tools package you just (re)installed.

-- 
Alex Goddard
agoddard@purdue.edu
