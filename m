Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757400AbWKWTDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400AbWKWTDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbWKWTDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:03:23 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5914 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1757400AbWKWTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:03:22 -0500
Subject: Re: [PATCH 0/4] Lumpy Reclaim V3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <exportbomb.1164300519@pinky>
References: <exportbomb.1164300519@pinky>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 20:02:59 +0100
Message-Id: <1164308579.3878.6.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 16:48 +0000, Andy Whitcroft wrote:

> lumpy-reclaim-v2 -- Peter Zijlstra's lumpy reclaim prototype,
> 
> lumpy-cleanup-a-missplaced-comment-and-simplify-some-code --
>   cleanups to move a comment back to where it came from, to make
>   the area edge selection more comprehensible and also cleans up
>   the switch coding style to match the concensus in mm/*.c,

Sure looks better.

> lumpy-ensure-we-respect-zone-boundaries -- bug fix to ensure we do
>   not attempt to take pages from adjacent zones, and

Valid case I guess :-)

> lumpy-take-the-other-active-inactive-pages-in-the-area -- patch to
>   increase aggression over the targetted order.

Yeah, I see how this will help.

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

for all 3

