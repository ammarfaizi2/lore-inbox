Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVAMOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVAMOwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVAMOwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:52:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29131 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261639AbVAMOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:49:23 -0500
Date: Thu, 13 Jan 2005 15:08:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: diegocg@gmail.com, kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
Message-ID: <20050113140844.GA2599@openzaurus.ucw.cz>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112153131.1f778264.diegocg@gmail.com> <E1CojqJ-0001Mw-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CojqJ-0001Mw-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -You could implement several "not-performance-critical" filesystems (fat,
> >  isofs) with FUSE to avoid possible security issues. Give that nowadays 
> >  usb sticks and cd/dvds are so common it'd be possible to modify a filesystem
> >  on purpose to crash the kernel if a bug were found in those filesytems. With
> >  FUSE that posibility decreases.
> 
> One of my pet ideas, is a userspace loopback mounter, which would use
> UML to actually mount an image, and export the resulting filesystem
> through FUSE to the host.
> 
> Brilliant isn't it?

Uh, yes, it actually makes sense.

OTOH perhaps porting linux's vfs to userland would be better idea.
People would like to tap on .iso images in mc to open them, but running
full UML to do this is little heavy-weight solution.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

