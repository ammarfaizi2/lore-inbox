Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTI3P1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTI3P1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:27:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61188 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261580AbTI3P1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:27:24 -0400
Date: Tue, 30 Sep 2003 11:17:51 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030930104201.GA11752@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.3.96.1030930111443.9817A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, [iso-8859-1] Jörn Engel wrote:

> On Mon, 29 September 2003 19:19:30 +0000, bill davidsen wrote:
> > In article <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>,
> > Linus Torvalds  <torvalds@osdl.org> wrote:
> > 
> > | Interesting. I'm pretty sure I did a "make allyesconfig" just before the
> > | test6 release, so apparently x86 includes it indirectly through some path, 
> > | and so it only shows up on m68k and arm?
> > | 
> > | This, btw, is a pretty common thing. I wonder what we could do to make 
> > | sure that different architectures wouldn't have so different include file 
> > | structures. It's happened _way_ too often.
> > | 
> > | Any ideas?
> > 
> > If CPU cycles are no object the include names and order can be picked
> > out of the preprocessor output, add "-E" to the gcc call, pick only the
> > lines starting with "1" and a header name, save in a text file. The
> > problem is that config option (including arch) change the output, so
> > it's only useful as a rough check.
> 
> How is this better than adding "-H", as Jamie suggested?

I didn't see that in Linus' post, and still don't. I suspect you're
thinking of some post which came later. Linus asked for ideas, I supplied
one, sorry it offends you.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

