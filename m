Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVAMOwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVAMOwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVAMOwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:52:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29387 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261641AbVAMOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:49:23 -0500
Date: Thu, 13 Jan 2005 15:37:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, kinema@gmail.com,
       fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
Message-ID: <20050113143729.GB2599@openzaurus.ucw.cz>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112110109.6a21fae5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112110109.6a21fae5.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  Well, there doesn't seem to be a great rush to include FUSE in the
> >  kernel.  Maybe they just don't realize what they are missing out on ;)
> 
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

Right now, every project (mc, gnome, kde) has their own vfs implementation,
so that they can work transparently over ftp, handle archives, etc.

Done properly, userspace filesystem like fuse can unify those, plus provide better caching.
It also has chance to be a place for  niche filesystems (like atari800) that would be too much pain to keep in kernel.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

