Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262991AbTC0OsR>; Thu, 27 Mar 2003 09:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262994AbTC0OsR>; Thu, 27 Mar 2003 09:48:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3336 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262991AbTC0OsQ>; Thu, 27 Mar 2003 09:48:16 -0500
Date: Thu, 27 Mar 2003 09:55:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <Pine.LNX.4.44.0303261841070.1439-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030327095113.12939A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Hugh Dickins wrote:

> On Wed, 26 Mar 2003, Bill Davidsen wrote:
> > 
> > Unless there's a subtle difference in functionality here that I'm missing,
> > you are doing the same thing in a larger and slower way, and the logic is
> > less clear.
> > 
> > Is there some benefit I'm missing?
> 
> No, it's just that Andrew finds the logic clearer when written out his way.

Looking a code generated from fragments, I don't think gcc shares that
opinion ;-) Actually I find it more obvious with the ? notation, and it
prevents someone in the future changing the logic in one line of code when
it needs to change in both.

Oh well, I expect the ? form to stay, since it uses less cache.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

