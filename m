Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281408AbRKEWoL>; Mon, 5 Nov 2001 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281407AbRKEWoC>; Mon, 5 Nov 2001 17:44:02 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6648 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281408AbRKEWns>;
	Mon, 5 Nov 2001 17:43:48 -0500
Date: Mon, 5 Nov 2001 15:41:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105154145.H3957@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Mike Fedyk <mfedyk@matchmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au> <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu> <3BE71131.59BA0CFC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BE71131.59BA0CFC@zip.com.au>; from akpm@zip.com.au on Mon, Nov 05, 2001 at 02:22:41PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2001  14:22 -0800, Andrew Morton wrote:
> But I don't know.  This is just all bullshit handwaving speculation.
> We need tests.  Numbers.  Does anyone have source to a filesystem
> aging simulation?  The Smith/Seltzer code seems to be off the air.

There is a guy doing fragmentation testing for reiserfs.  It turns
out that (in his tests) reiserfs can get 10x slower as the filesystem
fills up because of intra-file fragmentation.  I don't know enough 
about reiserfs block/file allocation policy to know how this compares
to ext2 at all.

See http://www.informatik.uni-frankfurt.de/~loizides/reiserfs/agetest.html

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

