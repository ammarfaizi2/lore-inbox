Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTIDRfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTIDRfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:35:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44684 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265342AbTIDRfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:35:38 -0400
Date: Thu, 4 Sep 2003 18:35:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904173511.GC30394@mail.jlokier.co.uk>
References: <20030903073628.GA19920@mail.jlokier.co.uk> <20030904014229.404F12C0CB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904014229.404F12C0CB@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I think this is a bit extreme: this would allow futexes in the
> VSYSCALL region, right?  I admire your thoroughness, but perhaps this
> should wait until someone comes up with a reason to do it?

I only put that in because map_user_pages does it.  It isn't important.

If you look carefully, you see that these patches work exactly like
the old implementation in all cases where the old one worked.

-- Jamie
