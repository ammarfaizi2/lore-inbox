Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGQUfB>; Wed, 17 Jul 2002 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSGQUfB>; Wed, 17 Jul 2002 16:35:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:45830 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316681AbSGQUe6>; Wed, 17 Jul 2002 16:34:58 -0400
Date: Wed, 17 Jul 2002 17:37:36 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <E17UtVY-0004On-00@starship>
Message-ID: <Pine.LNX.4.44L.0207171734390.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daniel Phillips wrote:

> It can be fixed in kernel too, it's just that the effort would be poorly
> spent at this point.  This is in roughly the same category as process-level
> paging policy: yes, if it's implemented properly the VM appears to work
> better and users will post nice things on lkml about it, but it's a red
> herring.  Such adjustments are better left for later in the cycle, when
> the smoke has cleared from the basic merge, and benchmarks should focus
> narrowly on behaviour that is actually affected by the change in scanning
> strategy.

I don't agree with this, for a very simple reason.

The current rmap patch was created in order to change the
VM behaviour as little as possible and ONLY provide an
infrastructure.  Benchmarking a completely untuned thing
that was built to not change anything is bound to give
meaningless results.

I say we _use_ the infrastructure that akpm is trying to
get merged now in order to implement something useful.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

