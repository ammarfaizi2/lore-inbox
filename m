Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269852AbRHDSaz>; Sat, 4 Aug 2001 14:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269851AbRHDSap>; Sat, 4 Aug 2001 14:30:45 -0400
Received: from weta.f00f.org ([203.167.249.89]:21136 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269850AbRHDSac>;
	Sat, 4 Aug 2001 14:30:32 -0400
Date: Sun, 5 Aug 2001 06:31:23 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semanticchange patch)
Message-ID: <20010805063123.A20164@weta.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0108031947080.5264-100000@weyl.math.psu.edu> <3B6BA82B.E02553D4@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6BA82B.E02553D4@namesys.com>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 11:45:47AM +0400, Hans Reiser wrote:

    Can you define f_cred for us?

Surely is becomes a fs-specific opaque type, void* or whatever?  For
many filesystems it somply won't be relevant, and for some filesystems
such as NFS and Coda, presumably it will need deep fs-specific
details?



  --cw

