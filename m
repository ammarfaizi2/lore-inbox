Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313932AbSDUVON>; Sun, 21 Apr 2002 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313934AbSDUVOM>; Sun, 21 Apr 2002 17:14:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5262 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313932AbSDUVOK>;
	Sun, 21 Apr 2002 17:14:10 -0400
Date: Sun, 21 Apr 2002 21:54:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Doug Ledford <dledford@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        ak@suse.de, pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020421195407.GB12120@elf.ucw.cz>
In-Reply-To: <20020418072615.I14322@dualathlon.random> <20020418094444.A2450@redhat.com> <20020418192003.GE11220@atrey.karlin.mff.cuni.cz> <20020418153238.A25037@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It introduces security hole: Unrelated tasks now have your top secret
> > value you stored in one of your registers.
> 
> Well, that's been my point all along and why I sent the patch.  I was not 
> asking why leaving the registers alone instead of 0ing them out was not a 
> security hole.  I was asking why doing so was not backward compatible?

Introducing security hole counts as "poor backcompatibility" to me.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
