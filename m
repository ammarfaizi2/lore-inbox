Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKRReU>; Mon, 18 Nov 2002 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSKRReU>; Mon, 18 Nov 2002 12:34:20 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34525 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263366AbSKRReU>;
	Mon, 18 Nov 2002 12:34:20 -0500
Date: Mon, 18 Nov 2002 17:39:16 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.47 Minor bug in non-fatal machine check
Message-ID: <20021118173916.GB15318@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <C8C38546F90ABF408A5961FC01FDBF1912E0E2@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E0E2@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 10:56:20AM -0800, Pallipadi, Venkatesh wrote:
 > 
 > A minor bug in nonfatal mcheck code. Non fatal machine check won't
 > find any MCE faults in CONFIG_SMP and num_online_cpus==1 case, as
 > mce_checkregs() will not be called at all. Attached patch should fix
 > this. 

Patch looks good to me..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
