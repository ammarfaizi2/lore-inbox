Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUEFUSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUEFUSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEFUSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:18:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:49478 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261418AbUEFUS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:18:29 -0400
Date: Thu, 6 May 2004 13:15:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       wli@holomorphy.com, rusty@rustcorp.com.au, joe.korty@ccur.com,
       jbarnes@sgi.com
Subject: Re: [PATCH mask 1/15] pj-fix-1-unifix
Message-Id: <20040506131545.29cb5b30.pj@sgi.com>
In-Reply-To: <20040506200555.GE28459@waste.org>
References: <20040506111814.62d1f537.pj@sgi.com>
	<20040506114629.74bea739.pj@sgi.com>
	<20040506200555.GE28459@waste.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> I really don't see how it has anything to do with the series.

It doesn't have anything to do with the series.

The 2.6.6-rc3-mm2 patch set could not be built (and that unifix patch
could not even be applied as a patch - due to being malformed).  So I
could not build and test the bitmap/cpumask patch against a vanilla
2.6.6-rc3-mm2.  Therefore I included a set of pj-fix-* patches, to get
2.6.6-rc3-mm2 healthy, before including the real bitmap/cpumask patches.

Notice that some patches are named pj-fix-*, and others named mask*.

And notice in the opening "[PATCH mask 0/15] bitmap and cpumask cleanup"
where I write:

pj-fix-1-unifix
pj-fix-2-ashoks-updated-cpuhotplug-6-7
pj-fix-3-ashoks-updated-cpuhotplug-7-7
pj-fix-4-include-mempolicy
pj-fix-5-syscall-return-semicolon
	Patches pj-fix-* should match fixes that you (Andrew)
	have already picked up.  You should ignore these
	if what you already have is just as good.  They are
	here so that I can be precise as to what source I
	am using for the basis of the following patches.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
