Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSERGAZ>; Sat, 18 May 2002 02:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSERGAY>; Sat, 18 May 2002 02:00:24 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:60913 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316755AbSERGAX>; Sat, 18 May 2002 02:00:23 -0400
Date: Fri, 17 May 2002 23:58:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Htree directory index for Ext2, updated
Message-ID: <20020518055808.GH21295@turbolinux.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178suL-0000Bs-00@starship> <20020518053458.GF21295@turbolinux.com> <E178x1B-0000DW-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2002  07:44 +0200, Daniel Phillips wrote:
> On Saturday 18 May 2002 07:34, Andreas Dilger wrote:
> > On May 18, 2002  03:21 +0200, Daniel Phillips wrote:
> > > Patch is severely broken in its current form, not only for the
> > > reasons you stated, but also because of its inability to handle
> > > renaming in any sane way.  I want a patch --sane option.
> > 
> > I bet BitKeeper gets it right... ;-) ;-) ;-)
> 
> Funny you should mention that, since Bitkeeper has embarrassed itself pretty
> badly with respect to patches, so far.
> 
>   - Somebody decided to add another level on top of the linux root directory
>     in their source directory.  I can't import patches into that.

Hmm, I'm not sure what you are referring to here.

>   - I can apply patches to bitkeeper repository using the normal 'patch',
>     but Bitkeeper gets its revenge later, as each bk edit command starts
>     off by throwing away the patch.

This is also strange, as when I use patch to apply a patch to files not
checked out, patch asks me if I should check them out in write mode
(which I do, of course).

Of course, if you are using patch to apply changes to a BK tree it isn't
really BK in the end.  What I was referring to was importing a changeset
would probably get the target files correct 100% of the time, unlike the
situation you are describing with patch.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

