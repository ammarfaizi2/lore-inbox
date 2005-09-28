Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVI1Sgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVI1Sgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVI1Sgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:36:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47752 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750721AbVI1Sgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:36:45 -0400
Date: Wed, 28 Sep 2005 11:36:36 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: show_free_area shows free pages in pcp list
In-Reply-To: <1127931469.5046.13.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0509281135080.14597@schroedinger.engr.sgi.com>
References: <20050928102219.A29282@unix-os.sc.intel.com> 
 <Pine.LNX.4.62.0509281037240.14338@schroedinger.engr.sgi.com>
 <1127931469.5046.13.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Rohit Seth wrote:

> > Its the number of free pages used by the pcp list.
> As you said, pcp is a cache of free pages.  From pcp's point-of-view,
> this is a count of free pages that is available for use.

This is the number of free pages on the list. Its the number of free 
pages "used" by the list and no longer accounted for by the zone 
free_pages count.

