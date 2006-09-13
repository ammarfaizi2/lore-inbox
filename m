Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWIMHPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWIMHPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 03:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWIMHPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 03:15:11 -0400
Received: from unthought.net ([212.97.129.88]:60422 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751643AbWIMHPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 03:15:09 -0400
Date: Wed, 13 Sep 2006 09:15:12 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Message-ID: <20060913071512.GA23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Dan Williams <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>,
	linux-raid@vger.kernel.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, christopher.leech@intel.com
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 04:00:32PM -0700, Dan Williams wrote:
> Neil,
> 
...
> 
> Concerning the context switching performance concerns raised at the
> previous release, I have observed the following.  For the hardware
> accelerated case it appears that performance is always better with the
> work queue than without since it allows multiple stripes to be operated
> on simultaneously.  I expect the same for an SMP platform, but so far my
> testing has been limited to IOPs.  For a single-processor
> non-accelerated configuration I have not observed performance
> degradation with work queue support enabled, but in the Kconfig option
> help text I recommend disabling it (CONFIG_MD_RAID456_WORKQUEUE).

Out of curiosity; how does accelerated compare to non-accelerated?

-- 

 / jakob

