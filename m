Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSJNEVM>; Mon, 14 Oct 2002 00:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJNEVM>; Mon, 14 Oct 2002 00:21:12 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:38643 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261817AbSJNEVL>; Mon, 14 Oct 2002 00:21:11 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 13 Oct 2002 22:23:23 -0600
To: Robert Love <rml@tech9.net>
Cc: Brian Jackson <brian-kernel-list@mdrx.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014042323.GP3045@clusterfs.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Brian Jackson <brian-kernel-list@mdrx.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org> <20021013161151.29293.qmail@escalade.vistahp.com> <1034531191.6032.4498.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034531191.6032.4498.camel@phantasy>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 13, 2002  13:46 -0400, Robert Love wrote:
> And this is really entirely the wrong attitude to take.  "Linux does not
> have volume management" and "High-end Linux applications need volume
> management" do not logically imply "we need to merge EVMS."

Well, I think the attitude is more like "I've never used volume
management, and high-end systems use volume management, therefore only
high end systems will benefit from volume management".

It's like Fortran programmers saying "I've gotten by with only static
memory allocation all of these years, do dynamic memory allocation in
C is just useless".  (Yes, I know "them's fightin' words" ;-)

The truth is that once you've gotten used to the LVM paradigm, going
back to "partitions" sucks, a lot.  Not having to over-allocate huge
gobs of disk to partitions because you don't want to backup, reformat, 
restore, repeat each time you manage to run out of space in a partition
is a big win, whether you're administering 1 disk drive or 1000.

Being able to create temporary volumes for whatever need strikes you,
increasing the amount of free space in your filesystem while it's
mounted, that's a big win in my books, even on a laptop (maybe even
_especially_ on a laptop where you can't easily add another disk).

Maybe there are some warts in EVMS, but that doesn't mean we don't
need it (or equivalent) in Linux.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

