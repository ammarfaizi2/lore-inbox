Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266464AbUA2WiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUA2WiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:38:16 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:9221 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266464AbUA2Whw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:37:52 -0500
Date: Thu, 29 Jan 2004 23:37:30 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129233730.A19497@pclin040.win.tue.nl>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040129201556.GK16675@khan.acc.umu.se>; from tao@acc.umu.se on Thu, Jan 29, 2004 at 09:15:56PM +0100
X-Spam-DCC: SIHOPE-DCC-3: kweetal.tue.nl 1085; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 09:15:56PM +0100, David Weinehall wrote:

> > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> 
> I can't really see the logic in this, though I know a lot of people do
> it.  I try to stay consistent, thus I do:
> 
> if ()
> for ()
> case ()
> while ()
> sizeof ()
> typeof ()
> 
> since they're all parts of the language, rather than
> functions/macros or invocations of such.

As you say, this is religion. Secondly, there need not be any logic.
But thirdly, if you insist: The first four are about flow of control.
We all agree they have spaces - it is Linux kernel standard.

On the other hand, sizeof is an arithmetical expression, often part
of larger expressions. Now expressions like
	sizeof (*foo)+1
might be confusing, and
	sizeof(*foo) + 1
shows more clearly what the parsing is.

Andries
