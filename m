Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSLBRkZ>; Mon, 2 Dec 2002 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSLBRkZ>; Mon, 2 Dec 2002 12:40:25 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:10712 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264657AbSLBRkY>;
	Mon, 2 Dec 2002 12:40:24 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15851.40133.974155.446342@harpo.it.uu.se>
Date: Mon, 2 Dec 2002 18:47:49 +0100
To: Christoph Hellwig <hch@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
In-Reply-To: <20021202195120.A25954@sgi.com>
References: <1033513407.12959.91.camel@phantasy>
	<20021104223725.A23168@sgi.com>
	<15851.37989.723028.614451@harpo.it.uu.se>
	<20021202195120.A25954@sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Mon, Dec 02, 2002 at 06:12:05PM +0100, Mikael Pettersson wrote:
 > > Is this implementation of set_cpus_allowed() Ok for all 2.4 kernels,
 > > even if they (like RH8.0's) use a non-vanilla scheduler?
 > 
 > No, it's for the stock scheduler.  But RH8.0 already has set_cpus_allowed().

I knew RH8.0 has set_cpus_allowed(), but I wanted to avoid having to check
for being compiled in a RH-hacked kernel. LINUX_VERSION_CODE doesn't
distinguish between standard and "with tons of vendor-specific changes" :-(

I'll use your code then on stock 2.4 kernels, and work out some kludge
for the RH case.

Thanks,

/Mikael
