Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSFRS7j>; Tue, 18 Jun 2002 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317551AbSFRS7i>; Tue, 18 Jun 2002 14:59:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7676 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317549AbSFRS7h>; Tue, 18 Jun 2002 14:59:37 -0400
Subject: Re: latest linus-2.5 BK broken
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206181155280.4552-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0206181155280.4552-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 11:59:37 -0700
Message-Id: <1024426778.1476.211.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 11:56, Linus Torvalds wrote:

> NO.
> 
> Rusty, people want to do "node-affine" stuff, which absolutely requires
> you to be able to give CPU "collections". Single CPU's need not apply.

I would also hate to have to make 32 system calls to get the affinity
mask I want.

If anything, I think the interface is not collective _enough_ - further
abstractions like psets seem to be in favor, not dropping down to a
one-CPU-and-task per-call thing.  Not that I am complaining, I am happy
with the interface...

	Robert Love

