Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUDGRVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDGRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:21:47 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:59268 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263815AbUDGRVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:21:34 -0400
Subject: Re: Rewrite Kernel
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040407150516.GC23517@marowsky-bree.de>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
	 <1081348038.5049.6.camel@redeeman.linux.dk>
	 <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk>
	 <20040407150516.GC23517@marowsky-bree.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1081358490.4927.14.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 19:21:30 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 17:05, Lars Marowsky-Bree wrote:
> Guys, gals,
> 
> you are all missing the point.
> 
> It is obvious that what we really need is a hand-optimized in-kernel
> core LISP machine written in >i386 assembly, then we need to port the
> rest of the kernel to run as LISP bytecode on top of that in ring1 (in
> particular the security policies).
> 
> Of course, important privileged user-space such as glibc should be
> ported to this highly efficient non-recursive LISP machine too for
> efficiency and run on ring 2 for speed and security.
> 
> As a further benefit, this could provide us with a stable kernel binary
> ABI via the LISP interfaces to which we could dynamically translate the
> existing kernel modules on load, for which nvidia and the binary-only
> Inifiband stack seem perfect candidates to secure industry buyin.

this is a good idea, but i doubt that anyone would dare to do that :D
> 
> Oh, and of course this project needs to be managed via BitKeeper.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
-- 
Regards, Redeeman
redeeman@metanurb.dk

