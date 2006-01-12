Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWALO3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWALO3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWALO3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:29:52 -0500
Received: from cabal.ca ([134.117.69.58]:18834 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1030414AbWALO3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:29:52 -0500
Date: Thu, 12 Jan 2006 09:28:43 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org, Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [parisc-linux] Re: [2.6 patch] arch/parisc/mm/init.c: fix SMP=y compilation
Message-ID: <20060112142843.GA31925@quicksilver.road.mcmartin.ca>
References: <20060112092017.GP29663@stusta.de> <20060112125020.GG19769@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112125020.GG19769@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:50:20AM -0700, Matthew Wilcox wrote:
> It's already this way in the parisc tree.  Kyle, did you miss part of
> the merge?

Indeed. I handcrafted most of the patches I applied, and it seems I forgot
to look for duplicates (patching the same file twice in the same diff)
so while one part of mm/init.c got fribbled, the other didn't. Fix
applied to my tree.

Thanks for pointing this out,
	Kyle
