Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265939AbUFDTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUFDTSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUFDTSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:18:15 -0400
Received: from holomorphy.com ([207.189.100.168]:26792 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265939AbUFDTSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:18:10 -0400
Date: Fri, 4 Jun 2004 12:17:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Paul Jackson <pj@sgi.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net, miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604191744.GK21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, Paul Jackson <pj@sgi.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net, miltonm@bga.com
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604190803.GA6651@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604190803.GA6651@krispykreme>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> This is patently ridiculous. Make a compat_sched_getaffinity(), and
>> likewise for whatever else is copying unsigned long arrays to userspace.

On Sat, Jun 05, 2004 at 05:08:03AM +1000, Anton Blanchard wrote:
> Did someone say compat_sched_getaffinity?
> Anton

Thank you.

On Sat, Jun 05, 2004 at 05:08:03AM +1000, Anton Blanchard wrote:
> Patch from Milton Miller that adds the sched_affinity syscalls into the
> compat layer. 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>

I'll sign off on it too if that helps any.


-- wli
