Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280693AbRKJT6z>; Sat, 10 Nov 2001 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280642AbRKJT6p>; Sat, 10 Nov 2001 14:58:45 -0500
Received: from md.hub.gts.cz ([194.213.32.136]:52865 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S280689AbRKJT6m>;
	Sat, 10 Nov 2001 14:58:42 -0500
Date: Sat, 1 Jan 2000 00:13:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Tim Jansen <tim@tjansen.de>,
        =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20000101001311.A35@(none)>
In-Reply-To: <20011107012009.B35@toy.ucw.cz> <Pine.LNX.4.33L.0111071913590.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0111071913590.2963-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Nov 07, 2001 at 07:14:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It eats CPU, it's error-prone, and all in all it's just "wrong".
> > >
> > > How much of your CPU time is spent parsing /proc files?
> >
> > 30% of 486 if you run top... That's way too much and top is unusable
> > on slower machines.
> > "Not fast enough for showing processes" sounds wery wrong.
> 
> Is this time actually spent parsing ascii, or is it procfs
> walking all the page tables of all processes ? ;)

About 1:1, probably. Readdir of /proc and open/read/parse/close is 
pretty expensive.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

