Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbUKQUsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUKQUsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKQUpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:45:17 -0500
Received: from gprs214-133.eurotel.cz ([160.218.214.133]:26244 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262472AbUKQUol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:44:41 -0500
Date: Wed, 17 Nov 2004 21:44:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041117204424.GC11439@elf.ucw.cz>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Coda should do the job, too... What are advantages of FUSE over Coda?
> 
> No, it couldn't do the job half as well.  You know, I did use Coda,
> until I had enough of it.  Now look at how many userspace filesystems
> were written based on CODA and how many on FUSE.

Well, there are filesystems based on NFS, which just plain do not
work... So #filesystems is not quite good argument.

> Coda is very different.  You can only read/write whole files in Coda.
> It's got a different attribute invalidation modell, a different access
> checking modell.  Generally it's much less flexible, which is OK since

I know I've asked before... but how is the "fuse-userspace-part
swapped out and memory full of dirty data on fuse" deadlock solved?

Coda has at least the advantage that coda-userspace-part does not need
to be page-locked.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
