Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHYV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHYV5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHYVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:54:52 -0400
Received: from waste.org ([209.173.204.2]:53188 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261602AbUHYVw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:52:58 -0400
Date: Wed, 25 Aug 2004 16:52:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825215217.GK5414@waste.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:22:55PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 25 Aug 2004, Christoph Hellwig wrote:
> > 
> > For one thing _I_ didn't decide about xattrs anyway.  And I still
> > haven't seen a design from you on -fsdevel how you try to solve the
> > problems with files as directories.
> 
> Hey, files-as-directories are one of my pet things, so I have to side with 
> Hans on this one. I think it just makes sense. A hell of a lot more sense 
> than xattrs, anyway, since it allows scripts etc standard tools to touch 
> the attributes.
> 
> It's the UNIX way.

I thought the UNIX way is "everything's a file", not "everything's a
directory".

> Will it potentially break something? Sure. Do we care? Me, I'll take that 
> kind of extension _any_ day over xattrs, that are fundamentally flawed in 
> my opinion and totally useless.

There's always the option that they're both broken.

-- 
Mathematics is the supreme nostalgia of our time.
