Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273860AbSISXf7>; Thu, 19 Sep 2002 19:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273863AbSISXf7>; Thu, 19 Sep 2002 19:35:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12502 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S273860AbSISXf6>;
	Thu, 19 Sep 2002 19:35:58 -0400
Date: Fri, 20 Sep 2002 01:46:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-J2, BK-curr
In-Reply-To: <20020920013246.A12393@suse.de>
Message-ID: <Pine.LNX.4.44.0209200146250.20078-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Dave Jones wrote:

>  > >  - add list_for_each_noprefetch() to list.h, for all those list users who 
>  > >    know that in the majority of cases the list is going to be short.
>  > That name is really ugly, as the lack ofthe prefetch is an implementation
>  > detail.  What about list_for_each_short or __list_for_each?
> 
> Wasn't this the reason we have list_for_each_safe() ?

no, list_for_each_safe() is a loop that is entry-removal safe.

	Ingo

