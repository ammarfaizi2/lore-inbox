Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVAKTvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVAKTvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVAKTvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:51:22 -0500
Received: from waste.org ([216.27.176.166]:11160 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262343AbVAKTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:50:37 -0500
Date: Tue, 11 Jan 2005 11:50:10 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111195010.GU2940@waste.org>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5wc9gx1.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 08:30:50AM -0600, Jack O'Quin wrote:
> > Let's work on that. It'd be _far_ better to have unprivileged near-RT
> > capability everywhere without potential scheduling DoS.
> 
> "Near-RT" is about the most useless concept I've heard of in a long
> time.  It sounds like the answer to a question nobody asked.  ;-)

To my way of thinking, it's a pretty good description of Ingo's work
or anything you're ever going to see on a PC. If you think you're
going to get real hard RT performance on your off-the-shelf x86 box
running a conventional OS, you are fooling yourself.

Thankfully a buffer underrun is no more fatal for pro audio than a
broken guitar string. CDs skip, DATs glitch, XLR cables flake out,
circuit breakers trip, amps clip, Powerbooks crash, and the show goes
on. I've done more than enough stage tech to know it's a huge pain in
the ass, but let's stop pretending we require absolute perfection,
please.

-- 
Mathematics is the supreme nostalgia of our time.
