Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265628AbUFIQkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUFIQkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUFIQkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:40:06 -0400
Received: from holomorphy.com ([207.189.100.168]:40325 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265628AbUFIQkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:40:02 -0400
Date: Wed, 9 Jun 2004 09:38:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040609163829.GQ1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Derr <Simon.Derr@bull.net>
References: <20040604081906.GR21007@holomorphy.com> <17995.1086338623@kao2.melbourne.sgi.com> <20040604095403.GW21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604095403.GW21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 02:54:03AM -0700, William Lee Irwin III wrote:
> I'd rather just do it.
> Index: irqaction-2.6.7-rc2/include/linux/interrupt.h
> ===================================================================
> --- irqaction-2.6.7-rc2.orig/include/linux/interrupt.h	2004-05-29 23:26:11.000000000 -0700
> +++ irqaction-2.6.7-rc2/include/linux/interrupt.h	2004-06-04 02:24:12.348627000 -0700

I should mention that I've tested this change on sparc64 and it worked
beautifully.


-- wli
