Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316904AbSEVJnc>; Wed, 22 May 2002 05:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSEVJnb>; Wed, 22 May 2002 05:43:31 -0400
Received: from dsl-213-023-040-073.arcor-ip.net ([213.23.40.73]:11946 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316904AbSEVJna>;
	Wed, 22 May 2002 05:43:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Htree directory index for Ext2, updated
Date: Wed, 22 May 2002 11:43:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178xSu-0000Dc-00@starship> <20020518172634.GK21295@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ASeO-0001xB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 May 2002 19:26, Andreas Dilger wrote:
> On May 18, 2002  08:13 +0200, Daniel Phillips wrote:
> > I cloned a repository that is arranged like:
> > 
> >   somedir
> >     |
> >     |--linux
> >     |    |
> >     |    The usual stuff
> >     |
> >      `---other things
> > 
> > Bitkeeper wants the destination for the import to be 'somedir', and
> > cannot figure out how to apply a patch that looks like:
> > +++ src/include/linux/someheader.h, for instance.
> 
> And that is bad in what way?

It is bad in that there is no way to import the patch into BitKeeper.

> If you try to apply that patch from
> 'somedir' you expect patch/BK to have ESP to know it should apply
> under 'linux'.  If 'patch' will apply such a diff, then it is just
> a sign of the problems you were complaining about - that it uses
> heuristics to guess which file to modify, and they are not 100% right.
> 
> Of course, if you are really talking about a patch, and not a BK
> changeset, then the problem lies solely with 'patch' and 'diff'
> and has nothing to do with BK at all.

It looks like a hole in BitKeeper.  How do you suggest I apply my
perfectly normal patch?

-- 
Daniel
