Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRKEW7M>; Mon, 5 Nov 2001 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281415AbRKEW7C>; Mon, 5 Nov 2001 17:59:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:14855 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281410AbRKEW6x>; Mon, 5 Nov 2001 17:58:53 -0500
Message-ID: <3BE71875.67D5011A@zip.com.au>
Date: Mon, 05 Nov 2001 14:53:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net,
        constantin.loizides@isg.de
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au> <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu> <3BE71131.59BA0CFC@zip.com.au>,
		<3BE71131.59BA0CFC@zip.com.au>; from akpm@zip.com.au on Mon, Nov 05, 2001 at 02:22:41PM -0800 <20011105154145.H3957@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 05, 2001  14:22 -0800, Andrew Morton wrote:
> > But I don't know.  This is just all bullshit handwaving speculation.
> > We need tests.  Numbers.  Does anyone have source to a filesystem
> > aging simulation?  The Smith/Seltzer code seems to be off the air.
> 
> There is a guy doing fragmentation testing for reiserfs.  It turns
> out that (in his tests) reiserfs can get 10x slower as the filesystem
> fills up because of intra-file fragmentation.  I don't know enough
> about reiserfs block/file allocation policy to know how this compares
> to ext2 at all.
> 
> See http://www.informatik.uni-frankfurt.de/~loizides/reiserfs/agetest.html
> 

Wow.  That looks nice.  Unfortunately the tarballs are
missing several files.  read.cxx, agesystem.cxx, etc.  Plus
a number of dud links.

Constantin, could you please check that the agesystem3 tarball
builds OK, maybe put up a new one?   Thanks.

-
