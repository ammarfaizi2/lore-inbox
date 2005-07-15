Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbVGOF2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbVGOF2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbVGOF2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:28:24 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21129 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S263216AbVGOF1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:27:39 -0400
Date: Fri, 15 Jul 2005 14:21:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
Message-ID: <20050715042146.GE7750@localhost.localdomain>
Mail-Followup-To: Christoph Lameter <christoph@lameter.com>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
References: <20050707055554.GC11246@localhost.localdomain> <Pine.LNX.4.62.0507141022440.14347@graphe.net> <20050715011428.GC7750@localhost.localdomain> <Pine.LNX.4.62.0507141858220.21873@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507141858220.21873@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 07:00:11PM -0700, Christoph Lameter wrote:
> On Fri, 15 Jul 2005, David Gibson wrote:
> 
> > Well, the COW patch implements a fault handler, obviously.  What
> > specifically where you thinking about?
> 
> About a fault handler of course and about surrounding scalability issues.
> I worked on some hugepage related patches last fall. Have you had a look 
> at the work of Ken, Ray and me on the subject?

I'm still not at all sure what you're getting at.  Do you mean the
demand-allocation patches which were floating around at some point - I
gather they're important for doing sensible NUMA allocation of
hugepages.  They have a small overlap with the COW code, in the fault
handler, but not much.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
