Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbUDGPGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbUDGPGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:06:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:1972 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263707AbUDGPFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:05:23 -0400
Date: Wed, 7 Apr 2004 17:05:16 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Rewrite Kernel
Message-ID: <20040407150516.GC23517@marowsky-bree.de>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <1081348038.5049.6.camel@redeeman.linux.dk> <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, gals,

you are all missing the point.

It is obvious that what we really need is a hand-optimized in-kernel
core LISP machine written in >i386 assembly, then we need to port the
rest of the kernel to run as LISP bytecode on top of that in ring1 (in
particular the security policies).

Of course, important privileged user-space such as glibc should be
ported to this highly efficient non-recursive LISP machine too for
efficiency and run on ring 2 for speed and security.

As a further benefit, this could provide us with a stable kernel binary
ABI via the LISP interfaces to which we could dynamically translate the
existing kernel modules on load, for which nvidia and the binary-only
Inifiband stack seem perfect candidates to secure industry buyin.

Oh, and of course this project needs to be managed via BitKeeper.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

