Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUA3OsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUA3OsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:48:12 -0500
Received: from thunk.org ([140.239.227.29]:62382 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261193AbUA3OsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:48:11 -0500
Date: Fri, 30 Jan 2004 09:44:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tim Hockin <thockin@hockin.org>, Andries Brouwer <aebr@win.tue.nl>,
       Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040130144442.GA5081@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tim Hockin <thockin@hockin.org>, Andries Brouwer <aebr@win.tue.nl>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <20040129233730.A19497@pclin040.win.tue.nl> <20040129225456.GM16675@khan.acc.umu.se> <20040129231724.GA814@hockin.org> <20040129234336.GQ16675@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129234336.GQ16675@khan.acc.umu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:43:36AM +0100, David Weinehall wrote:
> "Everyone" also sprinkles far too many parenthesis for their own code,
> just to be sure.  I've seen code such as
> 
> a = b * c + 1;
> 
> written as
> 
> a = ((b * c) + 1);
>  
> The question is rather, why should you insert superfluous parenthesis
> when they do no semantic difference, and do not improve readability in
> any way?  

I disagree; sometimes adding a few extra parenthesis *does* improve
readability, especially if the expression is complex.  Of course, if
it's that complex, you might be better off defining a few extra
variables and having named sub-expressions (it shouldn't make a
difference to a good compiler).

						- Ted
