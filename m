Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTEIVvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbTEIVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:51:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:11395 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263496AbTEIVvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:51:09 -0400
Date: Fri, 09 May 2003 12:49:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: dipankar@in.ibm.com, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-ID: <49830000.1052509765@[10.10.2.4]>
In-Reply-To: <20030509141012.GD2059@in.ibm.com>
References: <20030508013958.157b27b7.akpm@digeo.com> <20030509141012.GD2059@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering what we should do with this patch. The RCU stats display
> the #s of RCU requests and actual updates on each CPU. On a normal system
> they don't mean much to a sysadmin, so I am not sure if it is the right
> thing to include this feature. OTOH, it is extremely useful to detect
> potential memory leaks happening due to, say a CPU looping in
> kernel (and RCU not happening consequently). Will a CONFIG_RCU_DEBUG
> make it more palatable for mainline ?

I'd find that useful - if it has a measurable overhead. If not, just leave
it on all the time ;-)

M.

