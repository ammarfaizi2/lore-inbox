Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUESMJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUESMJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUESMJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:09:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:50832 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264131AbUESMJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:09:27 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Chris Mason <mason@suse.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Larry McVoy <lm@bitmover.com>, wli@holomorphy.com, hugh@veritas.com,
       adi@bitmover.com, support@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <200405190453.31844.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	 <200405172319.38853.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
	 <200405190453.31844.elenstev@mesatop.com>
Content-Type: text/plain
Message-Id: <1084968622.27142.5.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 08:10:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 06:53, Steven Cole wrote:
> On Tuesday 18 May 2004 08:38 am, Linus Torvalds wrote:
> > 
> > On Mon, 17 May 2004, Steven Cole wrote:
> > >
> > > No problems, and with PREEMPT of course.
> > 
> > Ok. Good. It's a small data-set, but the bug made sense, and so did the 
> > fix.
> 
> Perhaps a final note on this: I did more testing on reiserfs overnight with
> Chris' patch, and it survived eleven pulls and unpulls with no failures.

Good to hear.  We probably still need Andrew's truncate fix, this just
isn't the right workload to show it.  Andrew, that reiserfs fix survived
testing here, could you please include it?

-chris


