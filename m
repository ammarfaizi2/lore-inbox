Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUA3Rt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUA3Rt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:49:29 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:3991 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263330AbUA3Rt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:49:26 -0500
Date: Fri, 30 Jan 2004 18:49:23 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Theodore Ts'o" <tytso@mit.edu>, Tim Hockin <thockin@hockin.org>,
       Andries Brouwer <aebr@win.tue.nl>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040130174923.GU16675@khan.acc.umu.se>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tim Hockin <thockin@hockin.org>, Andries Brouwer <aebr@win.tue.nl>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <20040129233730.A19497@pclin040.win.tue.nl> <20040129225456.GM16675@khan.acc.umu.se> <20040129231724.GA814@hockin.org> <20040129234336.GQ16675@khan.acc.umu.se> <20040130144442.GA5081@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130144442.GA5081@thunk.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 09:44:42AM -0500, Theodore Ts'o wrote:
> On Fri, Jan 30, 2004 at 12:43:36AM +0100, David Weinehall wrote:
> > "Everyone" also sprinkles far too many parenthesis for their own code,
> > just to be sure.  I've seen code such as
> > 
> > a = b * c + 1;
> > 
> > written as
> > 
> > a = ((b * c) + 1);
> >  
> > The question is rather, why should you insert superfluous parenthesis
> > when they do no semantic difference, and do not improve readability in
> > any way?  
> 
> I disagree; sometimes adding a few extra parenthesis *does* improve
> readability, especially if the expression is complex.  Of course, if
> it's that complex, you might be better off defining a few extra
> variables and having named sub-expressions (it shouldn't make a
> difference to a good compiler).

Possibly "when they do" should've been "if they do" to clarify what I
meant.  I don't mean that dropping all superfluous parantheses are
necessarily good, but most of the time, people tend to sprinkle the code
with them just because they lack in their knowledge of basic
C-programming.  I'm not saying this is the case for the kernel, just
that I've seen it far too often.

I agree about the sub-expression bit though.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
