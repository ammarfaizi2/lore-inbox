Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319390AbSIFUwE>; Fri, 6 Sep 2002 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSIFUwE>; Fri, 6 Sep 2002 16:52:04 -0400
Received: from [195.39.17.254] ([195.39.17.254]:7040 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319390AbSIFUwD>;
	Fri, 6 Sep 2002 16:52:03 -0400
Date: Fri, 6 Sep 2002 09:57:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020906095743.A35@toy.ucw.cz>
References: <20020903.231907.21327801.davem@redhat.com> <20020904074612.BA6CE2C073@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020904074612.BA6CE2C073@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Sep 04, 2002 at 05:38:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually Rusty what's the big deal, add an "initializer"
> > arg to the macro.  It doesn't hurt anyone, it doesn't lose
> > any space in the kernel image, and the macro arg reminds
> > people to do it.
> > 
> > I think it's a small price to pay to keep a longer range
> > of compilers supported :-)
> 
> I disagree.  They might not have a convenient (static) initializer, in
> which case it's simply cruel and unusual, to work around an obscure
> compiler bug.

Ugh? of course it will always have convient initializer, namely zero.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

