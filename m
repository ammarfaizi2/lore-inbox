Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbRBVNUg>; Thu, 22 Feb 2001 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRBVNU1>; Thu, 22 Feb 2001 08:20:27 -0500
Received: from mail.valinux.com ([198.186.202.175]:50440 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129457AbRBVNUO>;
	Thu, 22 Feb 2001 08:20:14 -0500
To: phillips@innominate.de
CC: phillips@innominate.de, Linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <01022208282404.25968@gimli> (message from Daniel Phillips on
	Thu, 22 Feb 2001 08:24:08 +0100)
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <01022020011905.18944@gimli> <E14Vp9h-0001IB-00@beefcake.hdqt.valinux.com> <01022208282404.25968@gimli>
Message-Id: <E14VvfG-00035D-00@beefcake.hdqt.valinux.com>
Date: Thu, 22 Feb 2001 05:20:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@innominate.de>
   Date: Thu, 22 Feb 2001 08:24:08 +0100
   Content-Type: text/plain

   > Is it worth it?  Well, it means you lose an index entry from each
   > directory block, thus reducing your fanout at each node of the tree by a
   > worse case of 0.7% in the worst case (1k blocksize) and 0.2% if you're
   > using 4k blocksizes.

   I'll leave that up to somebody else - we now have two alternatives, the
   100%, no-compromise INCOMPAT solution, and the slightly-bruised but
   still largely intact forward compatible solution.  I'll maintain both
   solutions for now code so it's just as easy to choose either in the end.

Well, the $64,000 question is exactly how much performance does it cost?
My guess is that it will be barely measurable, but only benchmarks will
answer that question.

							- Ted
