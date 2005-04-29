Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVD2Ik2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVD2Ik2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVD2Ik2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:40:28 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:25999 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262473AbVD2IkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:40:18 -0400
Message-ID: <1680.10.10.10.24.1114764016.squirrel@linux1>
In-Reply-To: <20050429074043.GT21897@waste.org>
References: <20050426004111.GI21897@waste.org>
    <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
    <20050429060157.GS21897@waste.org>
    <3817.10.10.10.24.1114756831.squirrel@linux1>
    <20050429074043.GT21897@waste.org>
Date: Fri, 29 Apr 2005 04:40:16 -0400 (EDT)
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
From: "Sean" <seanlkml@sympatico.ca>
To: "Matt Mackall" <mpm@selenic.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, April 29, 2005 3:40 am, Matt Mackall said:

> This trade-off FAILS, as my benchmarks against Mercurial have shown.
> It trades 10x disk space for maybe 10% performance relative to my
> approach. Meanwhile, it makes a bunch of other things hard, namely the
> ones I've listed. Yes, you can hack around them, but the back end will
> still be bloated.

But since performance can be seen as worth so much more than disk, this
might still be a good tradeoff, even given your numbers.


> Mercurial is even younger (Linus had a few days' head start, not to
> mention a bunch of help), and it is already as fast as git, relatively
> easy to use, much simpler, and much more space and bandwidth
> efficient.


There are some really nice things about the git design, not just
performance related.   However, i have a git repository going back to the
start of 2.4 and for my uses there aren't any performance problems.  (okay
fsck-cache, gets oom killed but i suspect that can be fixed).

No _argument_ is going to change the fundamental design of git, it is what
it is.  Git started out as just an interim fix and maybe that's all it
will turn out to be.  But it's working pretty well so far, with lots of
room for improvement over time, and in my estimation Linus has made a
pretty compelling argument for the design tradeoffs he's made.

Sean


