Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVCRTtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVCRTtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVCRTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:47:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262011AbVCRTqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:46:31 -0500
Date: Fri, 18 Mar 2005 14:46:17 -0500
From: Dave Jones <davej@redhat.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: [PATCH] Reading deterministic cache parameters and exporting it in /sysfs
Message-ID: <20050318194616.GH24385@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, rohit.seth@intel.com
References: <20050315152448.A1697@unix-os.sc.intel.com> <20050315230736.6faa3734.akpm@osdl.org> <20050318111847.A32361@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318111847.A32361@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 11:18:47AM -0800, Venkatesh Pallipadi wrote:
 > 
 > Here is the updated patch. 
 > 
 > I have seperated out the changes related to 
 > (1) using new method to determine cache size in existing /proc/cpuinfo and
 >     kernel boot messages (All but last hunk below)
 > (2) code to look at sharedness of the caches and store these details for future
 >     uses inside kernel and also exporting the cache details in /sysfs (last
 >     hunk in the patch)
 >   
 > Dave: Do you still feel having the cache details exported in /sysfs is a bad
 > idea? If yes, we can go ahead with the basic part of this patch (1 - above)
 > and look at (2) sometime later, as and when required.

tbh I think its just bloat, but if no-one else has any objections I won't oppose it.
The rest of the patch I have no problem with.

		Dave

