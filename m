Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSBFHQk>; Wed, 6 Feb 2002 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSBFHQa>; Wed, 6 Feb 2002 02:16:30 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:8708
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S290184AbSBFHQY>; Wed, 6 Feb 2002 02:16:24 -0500
Date: Wed, 6 Feb 2002 02:17:28 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre8 + 2.4.17-pre8-ac3 + rmap12c + XFS Results
Message-ID: <Pine.LNX.4.40.0202060213380.395-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to say that rmap12c has huge preformance improvements over
rmap11c with my Pentium 200Mhz w/64MB ram.

Some of the differences:

rmap11c: slow redrawing of mozilla, mouse hangs, system sluggishness.

rmap12c: no slow redrawing UNLESS heavy I/O & swapping is occuring. System
is able to handle heavy heavy memory usage (mozilla + evolution +
blowup-xfs - fsx-linux.c to test XFS's stability with VM).

Also, XFS so far is preforming without file corruption that I can see.

a patch will be available for this shortly on my website for those who
want XFS + rmap12c.

Shawn.

