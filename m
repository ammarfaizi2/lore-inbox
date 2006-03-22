Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWCVRcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWCVRcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWCVRcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:32:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50818 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751027AbWCVRcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:32:10 -0500
Date: Wed, 22 Mar 2006 09:32:28 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 09/35] Change __FIXADDR_TOP to leave room for the hypervisor.
Message-ID: <20060322173228.GX15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063747.636585000@sorel.sous-sol.org> <44218916.3030607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44218916.3030607@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Anthony Liguori (aliguori@us.ibm.com) wrote:
> I think this is more generally useful if it's actually a CONFIG option 
> (as it was in the VMI patches) instead of subarch specific.  Qemu has 
> had a "fast" patch for a while that pretty much just increases the size 
> of the memory hole and changes ___PAGE_OFFSET to be lower in memory.   
> There are a number of interesting things one can do once there's an 
> adequately sized hole too (assuming you're doing full-virtualization).

Good point, easy to change.  Although I think dynamic may be the better
approach.

thanks,
-chris
