Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVJES3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVJES3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVJES3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:29:49 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:37807 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030308AbVJES3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:29:48 -0400
Date: Wed, 5 Oct 2005 14:29:47 -0400
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [PATCH 1/5] AMD Geode GX/LX support V2
Message-ID: <20051005182947.GE8011@csclub.uwaterloo.ca>
References: <20051005164626.GA25189@cosmic.amd.com> <20051005165405.GB25189@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005165405.GB25189@cosmic.amd.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 10:54:05AM -0600, Jordan Crouse wrote:
> This patch combines the previous two patches which added individual defines
> for the GX and LX processors.   This patch just defineds MGEODE_LX for both
> processors.  Also, fixed the following issues
> 
> - fixed up the MGEODEGX1 cache line size to the correct value.
> - Removed GEODE_LX restrictions from IOAPIC and HIGHMEM (Alan Cox and others)
> - Removed GEODE_LX define from the 3DNOW config option pending conclusive
>   benchmark results that it increases performance (Alan Cox)
> - Fix up the GX1/GX cpu init function so that it is cleaner and more correct.
>   If anybody gets a NSC branded GX1 processor, it should jump into the
>   init_cyrix and do the right thing. (Alan Cox)
> - Updated the MAINTAINERS information (Adrian Bunk)

Which of those options apply to the SC1200 version of the geode and does
it use the same ide controller driver as the cs55x0 you had in your
previous patch?

There are starting to be too many geode's.  It's almost as confusing as
keeping track of Pentium models.

I currently build a 486 kernel for use on the sc1200 and it seems to run
pretty good that way.

Len Sorensen
