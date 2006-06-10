Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWFJQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWFJQAG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWFJQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:00:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751190AbWFJQAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:00:05 -0400
Date: Sat, 10 Jun 2006 18:00:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610160007.GD11634@stusta.de>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com> <20060610134645.GB11634@stusta.de> <20060610144228.GA6416@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610144228.GA6416@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 04:42:28PM +0200, Ingo Molnar wrote:
> 
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> > > I'd argue that whatever we call it, we need a standard, stable, 
> > > supported solution *soon* for large files, large filesystems, large 
> > > storage systems in Linux.
> > > 
> > > I'd think the quickest path is to relieve the pressure now in ext3.
> > 
> > Why aren't JFS and XFS good enough for relieving the pressure now?
> 
> Compatibility? Upgradability? Simplicity? Supportability?
> 
> Even ignoring all those arguments, i find your "ext3/ext4 is too 
> complex, use XFS or JFS" argument a bit naive. Please take a quick look 
> at the linecount of the filesystems in question:
>...

You missed my point (or I didn't make it clear enough):

It's no question that an improved version of ext3 will be available.
The only question is whether it will be ext3 or ext4.

My point was that if it takes a bit longer in the ext4 case, and during 
this time some people have this pressure of requiring it, they have the 
workaround of using other file systems.

Whether the "improve ext3" or the ext4 approach are better is a 
different question. Whether ext3 is better than XFS is also not what I 
was talking about.

It's simply that for the few people who need it now, other file systems 
are available as a workaround.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

