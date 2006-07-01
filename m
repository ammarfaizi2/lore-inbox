Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWGAJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWGAJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGAJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:42:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38160 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932603AbWGAJmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:42:08 -0400
Date: Sat, 1 Jul 2006 11:42:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Theodore Tso <tytso@mit.edu>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
Message-ID: <20060701094206.GA17588@stusta.de>
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <p73sllnvsej.fsf@verdi.suse.de> <20060630151432.GA21675@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630151432.GA21675@thunk.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 11:14:32AM -0400, Theodore Tso wrote:
> On Fri, Jun 30, 2006 at 12:39:48PM +0200, Andi Kleen wrote:
> > "Theodore Ts'o" <tytso@mit.edu> writes:
> > > 
> > > 1) The creation of a new filesystem codebase in the 2.6 kernel tree in
> > > /usr/src/linux/fs/ext4 that will initially register itself as the
> > > "ext3dev" 
> > 
> > Why not call it ext4 from the beginning too? Calling the directory
> > differently from the file system can only cause confusion.
> > 
> > I assume if it's marked very experimental people who value their data
> > will avoid it for the time being.
> 
> There were a lot of people who were concerned that simply marking it
> CONFIG_EXPERIMENTAL might not be enough for to make it very clear that
> the filesystem format is still changing.  In order to address this
> concern, we want /etc/fstab to make it abundantly clear that the
> filesystem format itself is not necessarily stable, and that new
> features are being added that might not be supported on older
> kernels.
>...

What about a dependency on CONFIG_BROKEN?

This will require everyone who wants to use it to manually edit the 
Kconfig file for removing the dependency - which sounds like a good 
idea.

> 							- Ted

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

