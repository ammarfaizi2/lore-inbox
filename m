Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272851AbSISUQN>; Thu, 19 Sep 2002 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272869AbSISUQN>; Thu, 19 Sep 2002 16:16:13 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:49935 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S272851AbSISUQM>; Thu, 19 Sep 2002 16:16:12 -0400
Date: Thu, 19 Sep 2002 21:21:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-J2, BK-curr
Message-ID: <20020919212111.A13366@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com> <Pine.LNX.4.44.0209192055480.14365-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209192055480.14365-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Sep 19, 2002 at 09:38:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 09:38:03PM +0200, Ingo Molnar wrote:
>  - add list_for_each_noprefetch() to list.h, for all those list users who 
>    know that in the majority of cases the list is going to be short.

That name is really ugly, as the lack ofthe prefetch is an implementation
detail.  What about list_for_each_short or __list_for_each?

