Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUFFIQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUFFIQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUFFIQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:16:24 -0400
Received: from holomorphy.com ([207.189.100.168]:44208 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263059AbUFFIQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:16:23 -0400
Date: Sun, 6 Jun 2004 01:16:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: anton@samba.org, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net, miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040606081600.GS21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, anton@samba.org, mikpe@csd.uu.se,
	nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net, miltonm@bga.com
References: <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604190803.GA6651@krispykreme> <20040605002827.2e539991.pj@sgi.com> <20040606010747.7c0dd03b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606010747.7c0dd03b.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
>> but rather the number (possibly an odd number) of u32 dest words,

On Sun, Jun 06, 2004 at 01:07:47AM -0700, Paul Jackson wrote:
> or the byte size of the destination buffer ...

I posted some code for you to cherrypick and run with here.
i.e. the copy_cpus_to_user32()/copy_cpus_from_user32() stuff.
Should be Message-ID: <20040605082647.GQ21007@holomorphy.com>

I can resend as a patch if need be.


-- wli
