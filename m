Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135557AbRDSFoF>; Thu, 19 Apr 2001 01:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135559AbRDSFn4>; Thu, 19 Apr 2001 01:43:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:60882 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135557AbRDSFnn>;
	Thu, 19 Apr 2001 01:43:43 -0400
Message-ID: <3ADE79DD.6B94362B@mandrakesoft.com>
Date: Thu, 19 Apr 2001 01:38:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@atnf.csiro.au>
Cc: "Edward S. Marshall" <esm@logic.net>, Rik van Riel <riel@conectiva.com.br>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU>
		<Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva>
		<20010418233618.A28546@labyrinth.local> <200104190506.f3J56ik01292@mobilix.atnf.CSIRO.AU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Exactly. A ChangeLog should pre preserved for all time. It is an
> incredibly useful tool. Many times I've gone back and checked when
> something was done, and in relation to other changes before, after or
> around the same time.

agreed

> Except the CONFIG_APM_IGNORE_SUSPEND_BOUNCE was in the apm.c source
> file (in a ChangeLog). So just ignoring Documentation/ won't solve the
> problem.
> 
> One trick I've used on my own (non-Linux) code is to insert a space
> after the first underscore. That fools the global search, but leaves
> the essence of the ChangeLog entry. It's a bit hackish, though.
> 
> A cleaner solution is to parse the source code, ignoring comment
> blocks. However, that's a bit more work.

Or CC the maintainers, who can manually check, distributing the work :)

The stuff in ChangeLogs is clearly not to be touched.  Various
documentation has to be examined manually to determine if its outdated
or not.  There is no 100% automatic way to do this.

	Jeff


-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
