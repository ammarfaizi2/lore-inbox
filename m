Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268507AbTANCPy>; Mon, 13 Jan 2003 21:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268508AbTANCPy>; Mon, 13 Jan 2003 21:15:54 -0500
Received: from dp.samba.org ([66.70.73.150]:20352 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268507AbTANCPx>;
	Mon, 13 Jan 2003 21:15:53 -0500
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.29749.496146.362762@argo.ozlabs.ibm.com>
Date: Tue, 14 Jan 2003 13:21:41 +1100
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 2/4 -- ppc arch
In-Reply-To: <20030113123323.GD2714@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com>
	<20030113123323.GD2714@in.ibm.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai writes:

> This one's for ppc.

[snip]

> -unsigned int prof_counter[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
> +DEFINE_PER_CPU(unsigned int, prof_counter) = 1;

I had already done something similar locally which I'll push to Linus
shortly.

Thanks,
Paul.
