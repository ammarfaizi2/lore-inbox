Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVKASeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVKASeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVKASeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:34:15 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28863
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751100AbVKASeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:34:15 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Tue, 1 Nov 2005 12:33:35 -0600
User-Agent: KMail/1.8
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
References: <20051030235440.6938a0e9.akpm@osdl.org> <Pine.LNX.4.58.0511011358520.14884@skynet> <20051101144622.GC9911@elte.hu>
In-Reply-To: <20051101144622.GC9911@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011233.36713.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 08:46, Ingo Molnar wrote:
> how will the 100% solution handle a simple kmalloc()-ed kernel buffer,
> that is pinned down, and to/from which live pointers may exist? That
> alone can prevent RAM from being removable.

Would you like to apply your "100% or nothing" argument to the virtual memory 
management subsystem and see how it sounds in that context?  (As an argument 
that we shouldn't _have_ one?)

>  Ingo

Rob
