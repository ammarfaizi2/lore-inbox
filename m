Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273787AbSISX1n>; Thu, 19 Sep 2002 19:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273788AbSISX1n>; Thu, 19 Sep 2002 19:27:43 -0400
Received: from ns.suse.de ([213.95.15.193]:18446 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S273787AbSISX1m>;
	Thu, 19 Sep 2002 19:27:42 -0400
Date: Fri, 20 Sep 2002 01:32:46 +0200
From: Dave Jones <davej@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-J2, BK-curr
Message-ID: <20020920013246.A12393@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com> <Pine.LNX.4.44.0209192055480.14365-100000@localhost.localdomain> <20020919212111.A13366@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020919212111.A13366@infradead.org>; from hch@infradead.org on Thu, Sep 19, 2002 at 09:21:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 09:21:11PM +0100, Christoph Hellwig wrote:

 > >  - add list_for_each_noprefetch() to list.h, for all those list users who 
 > >    know that in the majority of cases the list is going to be short.
 > That name is really ugly, as the lack ofthe prefetch is an implementation
 > detail.  What about list_for_each_short or __list_for_each?

Wasn't this the reason we have list_for_each_safe() ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
