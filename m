Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVI1UaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVI1UaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVI1UaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:30:05 -0400
Received: from fmr15.intel.com ([192.55.52.69]:6797 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750769AbVI1UaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:30:04 -0400
Subject: Re: [PATCH]: show_free_area shows free pages in pcp list
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0509281135080.14597@schroedinger.engr.sgi.com>
References: <20050928102219.A29282@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0509281037240.14338@schroedinger.engr.sgi.com>
	 <1127931469.5046.13.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0509281135080.14597@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 28 Sep 2005 13:37:25 -0700
Message-Id: <1127939845.5046.25.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 20:29:55.0203 (UTC) FILETIME=[63095D30:01C5C46B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 11:36 -0700, Christoph Lameter wrote:
> On Wed, 28 Sep 2005, Rohit Seth wrote:
> 
> > > Its the number of free pages used by the pcp list.
> > As you said, pcp is a cache of free pages.  From pcp's point-of-view,
> > this is a count of free pages that is available for use.
> 
> This is the number of free pages on the list. Its the number of free 
> pages "used" by the list and no longer accounted for by the zone 
> free_pages count.
> 

As we are dumping the information so putting the field name "count"
itself makes more sense.

-rohit



