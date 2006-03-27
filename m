Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWC0FB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWC0FB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWC0FB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:01:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16108 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750777AbWC0FB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:01:57 -0500
Subject: RE: [PATCH] less tlb flush in unmap_vmas
From: Lee Revell <rlrevell@joe-job.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200603220744.k2M7iBg05206@unix-os.sc.intel.com>
References: <200603220744.k2M7iBg05206@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 00:01:53 -0500
Message-Id: <1143435714.1792.227.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 23:44 -0800, Chen, Kenneth W wrote:
> 
> OK, I think it would be beneficial to take a latency measurement
> again,
> just to see how it perform now a day.  The dynamics might changed. 

I will test this with Ingo's latency tracer as soon as I get a chance.
I had previously posted results showing this to be a problem spot.

Lee

