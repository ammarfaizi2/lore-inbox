Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUHYUNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUHYUNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268498AbUHYUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:09:53 -0400
Received: from verein.lst.de ([213.95.11.210]:28098 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268534AbUHYUJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:09:07 -0400
Date: Wed, 25 Aug 2004 22:08:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825200859.GA16345@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412CEE38.1080707@namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:53:28PM -0700, Hans Reiser wrote:
> You ignored everything I said during the discussion of xattrs about how 
> there is no need to have attributes when you can just have files and 
> directories, and that xattrs reflected a complete ignorance of name 
> space design principles.

Actually in most of the discussion you simply didn't participate.  While
xattrs might not be the nicest interface they have the advantag of not
breaking the SuS assumption of what directories vs files are, and they
do not break the Linux O_DIRECTORY semantics that are defined and need
to solve real-world races either.

> When I said we should just add some nice 
> optional features to files and directories so that they can do 
> everything that attributes can do if they are used that way, you just 
> didn't get it.  You instead went for the quick ugly hack called xattrs.  
> You then got that ugly hack done first, because quick hacks are, well, 
> quick.  I then went about doing it the right way for Reiser4, and got 
> DARPA to fund doing it.  I was never silent about it.

For one thing _I_ didn't decide about xattrs anyway.  And I still
haven't seen a design from you on -fsdevel how you try to solve the
problems with files as directories.

> Now a cleanly architected filesystem with no attributes and just files 
> and directories that can do everything attributes are used for exists.  
> You don't want it to have the competitive advantage.  Instead, you want 
> it to have its clean design excised until you have something that 
> duplicates it ready to go, and only then should it be allowed that users 
> will use the features of your competitor's filesystem which you 
> disdained implementing for so long.

My competitors filesystem?  If you look at MAINTAINERS I maintain only
vxfs and sysvfs, neither of which I'd suggest anyone to run their system
on.

> Since you never studied or understood namespace design principles (or 
> you would not have created and supported xattrs), you want to rename it 
> to be called VFS, rewrite what we have done, and take over as the 
> maintainer, mangling its design in a committee clusterfuck as you go. 

Hans, please stop the personal crap or the black helicopters will kidnap
you.   When was the last time you actually worked on kernel namespace
code instead of talking marketing bullshit and ignoring all real world
problems.

> If you implement your filesystems as reiser4 plugins, and rename 
> reiser4's plugin code to be called "vfs", your filesystems will go 
> faster.  Not as fast as reiser4 though, because it has a better layout 
> and that affects performance a lot, but faster is faster....  See 
> www.namesys.com/benchmarks.html for details.

Could you pass on that crack pipe please?

