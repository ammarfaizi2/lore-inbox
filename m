Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRLOQTi>; Sat, 15 Dec 2001 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282793AbRLOQT3>; Sat, 15 Dec 2001 11:19:29 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:19384 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S282784AbRLOQTT>;
	Sat, 15 Dec 2001 11:19:19 -0500
Date: Sat, 15 Dec 2001 17:18:22 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: fsx for Linux showing up reiserfs problem?
In-Reply-To: <20011215154029.A3954@suse.de>
Message-ID: <Pine.LNX.4.21.0112151715490.30396-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Dave Jones wrote:


> I've done a few tests on local filesystems, and so far Ext2 & Ext3
> seem to be holding up..

I've tested ext3 on 2.4.17-pre8 and it works fine.

> Reiserfs however dies very early into the test..
> 
>   truncating to largest ever: 0x3f15f
>   READ BAD DATA: offset = 0x1d3d4, size = 0x962f
>   OFFSET  GOOD    BAD     RANGE
>   0x1d3d4 0x177d  0x0000  0x  563
>   operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops

I tested with reiserfs on 2.4.9-ac14 and 2.4.15-pre4-xfs and it fails in
the same way on both.

I tested on a xfs partition on the 2.4.15-pre4-xfs kernel and didn't get
any errors either.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

