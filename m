Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJaRYe>; Thu, 31 Oct 2002 12:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSJaRYe>; Thu, 31 Oct 2002 12:24:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61348 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262783AbSJaRYd>;
	Thu, 31 Oct 2002 12:24:33 -0500
Date: Thu, 31 Oct 2002 12:30:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stephen Frost <sfrost@snowman.net>
cc: Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <20021031171115.GT15886@ns>
Message-ID: <Pine.GSO.4.21.0210311226550.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Stephen Frost wrote:

> So you're not really arguing against ACLs, you're complaining that
> userspace is broken when there's shared write access.  That's fine,
> userspace should be fixed, inclusion of ACLs into the kernel shouldn't
> be denied because of this.  ACLs should be optional, of course, and if
> you want them some really noisy warnings about the problems of shared
> writeable area with current userspace tools.  Of course, that same
> warning should probably be included in 'groupadd'.

	No.  I'm saying that ACLs do not have a point until at least basic
userland gets ready for setups people want ACLs for.  Adding features that
can't be used until $BIG_WORK is done is idiocy in the best case and
danger in the worst.  Especially since $BIG_WORK does not depend on these
features.

