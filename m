Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSEVK0F>; Wed, 22 May 2002 06:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316929AbSEVK0E>; Wed, 22 May 2002 06:26:04 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:39417 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316928AbSEVK0D>; Wed, 22 May 2002 06:26:03 -0400
Date: Wed, 22 May 2002 04:23:54 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Htree directory index for Ext2, updated
Message-ID: <20020522102354.GB802@turbolinux.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178xSu-0000Dc-00@starship> <20020518172634.GK21295@turbolinux.com> <E17ASeO-0001xB-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2002  11:43 +0200, Daniel Phillips wrote:
> On Saturday 18 May 2002 19:26, Andreas Dilger wrote:
> > On May 18, 2002  08:13 +0200, Daniel Phillips wrote:
> > > I cloned a repository that is arranged like:
> > > 
> > >   somedir
> > >     |
> > >     |--linux
> > >     |    |
> > >     |    The usual stuff
> > >     |
> > >      `---other things
> > > 
> > > Bitkeeper wants the destination for the import to be 'somedir', and
> > > cannot figure out how to apply a patch that looks like:
> > > +++ src/include/linux/someheader.h, for instance.
> > 
> > And that is bad in what way?
> 
> It is bad in that there is no way to import the patch into BitKeeper.
> 
> It looks like a hole in BitKeeper.  How do you suggest I apply my
> perfectly normal patch?

cd somedir/linux; patch -p1 < foo.diff; bk citool

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

