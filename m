Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267693AbUG3Odm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUG3Odm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267694AbUG3Odm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:33:42 -0400
Received: from jade.spiritone.com ([216.99.193.136]:44704 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267693AbUG3OdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:33:22 -0400
Date: Fri, 30 Jul 2004 07:29:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm <linux-mm@kvack.org>, LSE <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, tony.luck@intel.com,
       Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] don't pass mem_map into init functions
Message-ID: <323330000.1091197761@[10.10.2.4]>
In-Reply-To: <1091142640.23502.118.camel@nighthawk>
References: <1091048123.2871.435.camel@nighthawk> <200407281501.19181.jbarnes@engr.sgi.com> <1091053187.2871.526.camel@nighthawk> <200407281539.40049.jbarnes@engr.sgi.com> <1091056702.2871.617.camel@nighthawk> <1091142640.23502.118.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that zone init code is yours from the initial CONFIG_NUMA port
> and the kva remap code.  Do you think it's ready to go upstream?  If so,
> do you want to send it, or should I?
>
> It works on the NUMAQ, on regular SMP and Jesse Barnes tested it too.

Which bit of the zone_init code are we talking about? the re-ordering you
did? If so, that looked OK, but I'd like to test it on the x440 as well,
I'll power that up this morning and test it.

M.

