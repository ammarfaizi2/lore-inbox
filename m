Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSKBGsP>; Sat, 2 Nov 2002 01:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSKBGsP>; Sat, 2 Nov 2002 01:48:15 -0500
Received: from thunk.org ([140.239.227.29]:22427 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265885AbSKBGsO>;
	Sat, 2 Nov 2002 01:48:14 -0500
Date: Sat, 2 Nov 2002 01:54:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Fix 2.5-bk build error
Message-ID: <20021102065444.GA16100@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	Roman Zippel <zippel@linux-m68k.org>
References: <E187Agn-0003b9-00@snap.thunk.org> <20021101002419.GA1683@rivenstone.net> <20021101004751.GB1683@rivenstone.net> <20021101010607.GC1683@rivenstone.net> <Pine.LNX.4.44.0211011239290.6949-100000@serv> <20021101172807.GA982@caphernaum.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101172807.GA982@caphernaum.rivenstone.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 12:28:07PM -0500, Joseph Fannin wrote:
> > BTW2 in the future above can be simplified into
> > 
> > config FS_MBCACHE
> > 	tristate
> > 	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
> > 	default EXT2_FS || EXT3_FS
>
>     Okay, here's a patch that does that.  Linus, this fixes a build
> error in your current -bk tree that happens when one of ext[23] is a
> module and the other is built-in.  Please apply it.

Um, Roman, am I right in understanding that when you say, "in the
future above can be simplified" means that infrastructure to support
this construct isn't merged into the 2.5 kernel yet?  

If this is correct, Linus, please don't apply Joseph Fannin's patch
just yet.

						- Ted
