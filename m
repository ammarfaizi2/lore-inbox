Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSGBUkn>; Tue, 2 Jul 2002 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGBUkm>; Tue, 2 Jul 2002 16:40:42 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:30066 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S310190AbSGBUkl>;
	Tue, 2 Jul 2002 16:40:41 -0400
Date: Tue, 2 Jul 2002 02:47:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@ufl.edu>
Cc: Pradeep Padala <ppadala@cise.ufl.edu>,
       Andrew D Kirch <Trelane@Trelane.Net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace vs /proc
Message-ID: <20020702004706.GB107@elf.ucw.cz>
References: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu> <1024609747.922.0.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024609747.922.0.camel@sinai>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As far as I could investigate, I didn't find any such interface in linux. 
> > Programs like strace do the tracing through ptrace only.
> > 
> > Please let me know if you know more about this.
> 
> There is no such interface in Linux and currently no plans to develop a
> Solaris-style /proc.

I believe such proc interface is wrong thing to do. ptrace() is really
very *very* special thing, and you don't want it hidden in some kind
of /proc magic.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
