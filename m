Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSK1Qhp>; Thu, 28 Nov 2002 11:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSK1Qhp>; Thu, 28 Nov 2002 11:37:45 -0500
Received: from ns.netrox.net ([64.118.231.130]:41095 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S265777AbSK1Qhn>;
	Thu, 28 Nov 2002 11:37:43 -0500
Subject: Re: [Q] Which kernel + special patches ???
From: Robert Love <rml@tech9.net>
To: Till Immanuel Patzschke <tip@inw.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DE5D2AD.72686009@inw.de>
References: <3DE5D2AD.72686009@inw.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 11:46:28 -0500
Message-Id: <1038501991.908.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 03:24, Till Immanuel Patzschke wrote:

> following this list for quite a while now raised the above question.  To get
> more specific:
> Given an SMP system with many thousand processes and a potentially high network
> and IO load, what is the best combination of source and patch, to make best use
> of SMP, keep load low and throughput high?

Personally, I use 2.4-ac which includes rmap, the O(1) scheduler, and a
couple performance tweaks like read-latency and irq balancing.

But I have seen some excellent numbers from 2.4-aa, so you may want to
try that out, especially now that Andrea has the O(1) scheduler in
there.  2.4-aa has a large collection of performance patches.  Andrew
Morton says that is the best performing 2.4 kernel he has seen.

Your best bet is 2.6 when it comes out :)

> Many thanks for the help and Happy Thanksgiving!

Same to you.

	Robert Love

