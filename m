Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSKBLq7>; Sat, 2 Nov 2002 06:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265938AbSKBLq7>; Sat, 2 Nov 2002 06:46:59 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:40460 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265936AbSKBLq6>; Sat, 2 Nov 2002 06:46:58 -0500
Date: Sat, 2 Nov 2002 12:53:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Fix 2.5-bk build error
In-Reply-To: <20021102065444.GA16100@think.thunk.org>
Message-ID: <Pine.LNX.4.44.0211021246560.6949-100000@serv>
References: <E187Agn-0003b9-00@snap.thunk.org> <20021101002419.GA1683@rivenstone.net>
 <20021101004751.GB1683@rivenstone.net> <20021101010607.GC1683@rivenstone.net>
 <Pine.LNX.4.44.0211011239290.6949-100000@serv> <20021101172807.GA982@caphernaum.rivenstone.net>
 <20021102065444.GA16100@think.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Nov 2002, Theodore Ts'o wrote:

> On Fri, Nov 01, 2002 at 12:28:07PM -0500, Joseph Fannin wrote:
> > > BTW2 in the future above can be simplified into
> > > 
> > > config FS_MBCACHE
> > > 	tristate
> > > 	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
> > > 	default EXT2_FS || EXT3_FS
> >
> >     Okay, here's a patch that does that.  Linus, this fixes a build
> > error in your current -bk tree that happens when one of ext[23] is a
> > module and the other is built-in.  Please apply it.
> 
> Um, Roman, am I right in understanding that when you say, "in the
> future above can be simplified" means that infrastructure to support
> this construct isn't merged into the 2.5 kernel yet?  

No, it means that the support for this isn't written yet. I have looked 
into it, but it's not actually done yet.

bye, Roman

