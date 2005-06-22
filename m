Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVFVJEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVFVJEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVFVJA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:00:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37037 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262873AbVFVIyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:54:09 -0400
Date: Wed, 22 Jun 2005 10:53:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050622085352.GB1863@elf.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You have a choice of: 1) believe me that the current solution is
> > > fine
> > 
> > >  2) get down and try to understand the damn thing, and then come up
> > >     with technical arguments for/against it
> > 
> > Argument is "it is **** ugly".
> 
> Yeah, that's your opinion.  Mine is that it's f****** beautiful ;).
> 
> There are plenty of ugly things in Unix/Linux that you've become so
> accustomed to, that they no longer seem ugly.  Think about the sticky
> bit on directories for example.  That one was breaking assumptions
> left and right when it got introduced, but people came to accept it,
> because it's useful.

Just for the record, I still consider sticky bit "slightly" ugly and
nfs root squash "very" ugly.

> > Your fuse.txt explains why it is not security hole. It does not
> > explain why your interface is the best possible, and what alternative
> > ways of "not security hole" exist.
> 
> That's because I don't see any alternative.  The "preventing user from
> tracing root" and "preventing access to user's filesysem by root" must
> come together.  There's doesn't seem to be any other way.

It is clear that we can't allow root (or anyone else) to access that
filesystem. Infinite namespace is nice trap.

> BTW, thanks for reading through fuse.txt :)

You are welcome ;-).
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
