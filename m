Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281224AbRKTSmx>; Tue, 20 Nov 2001 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKTSmd>; Tue, 20 Nov 2001 13:42:33 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:19193 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281202AbRKTSm3>;
	Tue, 20 Nov 2001 13:42:29 -0500
Date: Tue, 20 Nov 2001 11:41:24 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@criticalsoftware.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: copy to suer space
Message-ID: <20011120114124.T1308@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@criticalsoftware.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111201714.fAKHEc276467@criticalsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111201714.fAKHEc276467@criticalsoftware.com>; from lhenriques@criticalsoftware.com on Tue, Nov 20, 2001 at 05:08:52PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  17:08 +0000, Luís Henriques wrote:
> > I don't think what you are trying to do is possible. Even if you somehow
> > managed to write over the code segment of a user space process (which I
> > very much doubt would be possible as I assume the memory is mapped
> > read-only)
> 
> Is there a way to solve this problem? To temporarly turn it read/write?
> 
> >, as soon as the kernel pages out (i.e. discards!) some portion
> > of the executable due to memory shortage your changes would be lost, since
> > the paging back into memory would happen by reading the executable back
> > from disk, which would mean it would read the unmodified code into
> > memory...
> 
> When I'm modifing the code, I'm sure that the page is in memory because my 
> code is called from the user space, in the exact location where I want to 
> change it (with a breakpoint interruption...)
> 
> The point is that I can't write to the memory location I want... How do I 
> solve this?

Maybe if you describe the actual problem that you are trying to solve, and
not the actual way you are trying to solve it, there may be a better method.
Usually, if something you are trying to do is very hard to do, there is a
different (much better) way of doing it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

