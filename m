Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWINHmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWINHmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWINHmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:42:45 -0400
Received: from unthought.net ([212.97.129.88]:14856 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751433AbWINHmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:42:44 -0400
Date: Thu, 14 Sep 2006 09:42:48 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Dan Williams <dan.j.williams@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>,
       linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Message-ID: <20060914074248.GD23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Dan Williams <dan.j.williams@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>,
	linux-raid@vger.kernel.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, christopher.leech@intel.com
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060913071512.GA23492@unthought.net> <e9c3a7c20609131217q145fb234q36f70b23f1acf950@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c3a7c20609131217q145fb234q36f70b23f1acf950@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 12:17:55PM -0700, Dan Williams wrote:
...
> >Out of curiosity; how does accelerated compare to non-accelerated?
> 
> One quick example:
> 4-disk SATA array rebuild on iop321 without acceleration - 'top'
> reports md0_resync and md0_raid5 dueling for the CPU each at ~50%
> utilization.
> 
> With acceleration - 'top' reports md0_resync cpu utilization at ~90%
> with the rest split between md0_raid5 and md0_raid5_ops.
> 
> The sync speed reported by /proc/mdstat is ~40% higher in the accelerated 
> case.

Ok, nice :)

> 
> That being said, array resync is a special case, so your mileage may
> vary with other applications.

Every-day usage I/O performance data would be nice indeed :)

> I will put together some data from bonnie++, iozone, maybe contest,
> and post it on SourceForge.

Great!

-- 

 / jakob

