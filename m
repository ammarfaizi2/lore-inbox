Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSLFSEM>; Fri, 6 Dec 2002 13:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSLFSEM>; Fri, 6 Dec 2002 13:04:12 -0500
Received: from holomorphy.com ([66.224.33.161]:4496 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265564AbSLFSEL>;
	Fri, 6 Dec 2002 13:04:11 -0500
Date: Fri, 6 Dec 2002 10:11:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@sgi.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021206181132.GQ9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@sgi.com>, rml@tech9.net,
	linux-kernel@vger.kernel.org
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com> <20021204004234.GL11730@dualathlon.random> <3DED5700.C32DC2B0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DED5700.C32DC2B0@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 05:14:40PM -0800, Andrew Morton wrote:
> I just retested.  This is on uniprocessor.  Running `make -j1 bzImage',
> while typing into a StarOffice 5.2 document:

I just reproduced the kernel compile issue by forgetting to run a
kernel compile niced down on UP, and getting many ccache misses.


Bill
