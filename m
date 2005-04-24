Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVDXUaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVDXUaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVDXUaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:30:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58325 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262405AbVDXU3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:29:47 -0400
Date: Sun, 24 Apr 2005 22:29:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, drzeus-list@drzeus.cx, torvalds@osdl.org,
       pasky@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424202919.GE30088@elf.ucw.cz>
References: <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz> <20050423233809.GA21754@kroah.com> <20050424032622.3aef8c9f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424032622.3aef8c9f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The main issue is if you want to use git for development and accepting
> > > > patches from others, you need to be used to not using that git tree to
> > > > send patches to Linus.  To send patches to him, do something like the
> > > > following:
> > > > 	- export the patches from your git tree
> > > > 	- pick and choose what you want to send off, cleaning up the
> > > > 	  changelog comments and merging patches that need to be.
> > > > 	- clone the latest copy of Linus's tree.
> > > > 	- apply the patches to that tree.
> > > > 	- make the tree public
> > > > 	- generate an email with the diffs and send that off to lkml and
> > > > 	  Linus.
> > > > 
> > > > Because of all of this, I've found that it is easier to use quilt for
> > > > day-to-day development and acceptance of patches.  Then use git to build
> > > > up trees for Linus to pull from.
> > > > 
> > > > But you might find your workflow is different :)
> > > 
> > > How does Andrew fit into this picture, btw? I thought all patches ought
> > > to go through him... Is Andrew willing to pull from git trees? Or is
> > > it "create one version for akpm, and when he ACKs it, create another
> > > for Linus"?
> > 
> > Yeah, getting Andrew into the picture is a bit different.
> 
> Andrew has some work to do before he can regain momentum:
> 
> - Which subsystem maintainers will have public git trees?

I'd like to use git. It sucks for actuall development, but seems to be
very usefull for taking nice and clean patches from people...

> - Which maintainers will continue to use bk?
> 
> - Can Andrew legally use the bk client?

I guess you need to Cc Larry on this one....
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
