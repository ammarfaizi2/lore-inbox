Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUDSHGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 03:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUDSHGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 03:06:47 -0400
Received: from holomorphy.com ([207.189.100.168]:40338 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263517AbUDSHGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 03:06:45 -0400
Date: Mon, 19 Apr 2004 00:06:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040419070643.GG743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	pj@sgi.com
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419062914.GE743@holomorphy.com> <20040418234214.7bfb5392.akpm@osdl.org> <20040419064943.GF743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419064943.GF743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 11:49:43PM -0700, William Lee Irwin III wrote:
> Quick story is that what I sent is (what I believe) to be the bare
> minimum change to restore correctnes.
> I'll start arguing with people to make sure bugfixes start moving and
> cleanups start waiting.
> Paul, please remove akpm from the cc: list in future replies until we
> have come to a consensus and get this nailed down (hopefully ASAP) to
> a coherent cross-vendor story.
> What I believe I have sent is the bare minimum change, with no cleanups
> or semantic changes. If you could review and/or send approval or the
> like that would be very helpful for the users of small SMP systems who
> are affected by the bug(s) you reported.

One last thing: I'm not opposed to cleanups in the least.

What I'm most concerned about is that arch maintainers have their needs
satisfied by whatever internals you choose to back cpumask* with.

In all honesty, what you've been proposing is very close to what I wanted
to have done to begin with. I would be glad to have you (or whoever else
has the wherewithal to push the issue) get things down to the cleanest and
most generally applicable implementation of API or definition of API as
possible.

I have taken issue only where I believe you need to acquire arch maintainer
feedback. IMHO, the changes proposed would be cleanups and more extensible,
but only need the review from arch maintainers to bring them to full
mainline merging. This is an API. When you have semantic equivalence, as
approved by arch maintainers, this has no reason _not_ to go in.

All this said, you have pointed out immediate needs for fixes. Please let
these fixes go through. There is a difference between the best code
possible and what makes things work.


-- wli
