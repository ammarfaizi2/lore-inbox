Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGQUjv>; Wed, 17 Jul 2002 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGQUjv>; Wed, 17 Jul 2002 16:39:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24051 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316695AbSGQUju>; Wed, 17 Jul 2002 16:39:50 -0400
Subject: Re: [patch 1/13] minimal rmap
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207171734390.12241-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207171734390.12241-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Jul 2002 13:42:41 -0700
Message-Id: <1026938562.1085.59.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 13:37, Rik van Riel wrote:

> I don't agree with this, for a very simple reason.
> 
> The current rmap patch was created in order to change the
> VM behaviour as little as possible and ONLY provide an
> infrastructure.  Benchmarking a completely untuned thing
> that was built to not change anything is bound to give
> meaningless results.
> 
> I say we _use_ the infrastructure that akpm is trying to
> get merged now in order to implement something useful.

I do agree with Rik here.  Once the basic rmap infrastructure is merged
we need to work on implementing stuff on top of it or else there is no
point.

If we cannot show the infrastructure is useful, then Linus will surely
rip rmap out of the kernel in time.

Summary: once it is in and seems correct we need to start providing (in
_pieces_) parts from Rik's full rmap patch and other VM-related code for
2.5 to see where rmap can take us...

	Robert Love

