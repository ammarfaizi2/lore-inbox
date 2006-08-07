Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWHGRiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWHGRiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWHGRiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:38:25 -0400
Received: from wind.enjellic.com ([209.243.13.15]:44768 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP id S1750785AbWHGRiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:38:25 -0400
Message-Id: <200608071737.k77Hbjph002429@wind.enjellic.com>
From: greg@enjellic.com
Date: Mon, 7 Aug 2006 12:37:45 -0500
In-Reply-To: Theodore Tso <tytso@mit.edu>
       "Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion" (Jul 31,  3:41pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Theodore Tso <tytso@mit.edu>, Adrian Ulrich <reiser4@blinkenlights.ch>,
       vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 31,  3:41pm, Theodore Tso wrote:
} Subject: Re: the " 'official' point of view" expressed by kernelnewbies.or

> On Mon, Jul 31, 2006 at 06:54:06PM +0200, Matthias Andree wrote:
> > > > This looks rather like an education issue rather than a technical limit.
> > > 
> > > We aren't talking about the same issue: I was asking to do it
> > > on-the-fly. Umounting the filesystem, running e2fsck and resize2fs
> > > is something different ;-)
> > 
> > There was stuff by Andreas Dilger, to support "online" resizing of
> > mounted ext2 file systems. I never cared to look for this (does it
> > support ext3, does it work with current kernels, merge status) since
> > offline resizing was always sufficient for me.

> With the latest e2fsprogs and 2.6 kernels, the online resizing
> support has been merged in, and as long as the filesystem was
> created with space reserved for growing the filesystem (which is now
> the default, or if the filesystem has the off-line prepration step
> ext2prepare run on it), you can run resize2fs on a mounted
> filesystem and grow an ext2/3 filesystem on-line.  And yes, you get
> more inodes as you add more disk blocks, using the original inode
> ratio that was established when the filesystem was created.

Are all the necessary tools in and documented in e2fsprogs?

It seems that finding all the bits and pieces to do ext3 on-line
expansion has been a study in obfuscation.  Somewhat surprising since
this feature is a must for enterprise class storage management.

> 						- Ted

Best wishes for a productive week.

}-- End of excerpt from Theodore Tso

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-1686
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Ooohh.. FreeBSD is faster over loopback, when compared to Linux over
the wire.  Film at 11."
                                -- Linus Torvalds
