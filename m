Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUG2XRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUG2XRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUG2XRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:17:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42234 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267490AbUG2XRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:17:49 -0400
Subject: Re: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-mm <linux-mm@kvack.org>, LSE <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, tony.luck@intel.com,
       Jesse Barnes <jbarnes@engr.sgi.com>
In-Reply-To: <1091056702.2871.617.camel@nighthawk>
References: <1091048123.2871.435.camel@nighthawk>
	 <200407281501.19181.jbarnes@engr.sgi.com>
	 <1091053187.2871.526.camel@nighthawk>
	 <200407281539.40049.jbarnes@engr.sgi.com>
	 <1091056702.2871.617.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1091142640.23502.118.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 16:10:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I think that zone init code is yours from the initial CONFIG_NUMA port
and the kva remap code.  Do you think it's ready to go upstream?  If so,
do you want to send it, or should I?

It works on the NUMAQ, on regular SMP and Jesse Barnes tested it too.

-- Dave

