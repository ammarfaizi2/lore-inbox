Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTKGCGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 21:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKGCGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 21:06:34 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63076 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262674AbTKGCGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 21:06:32 -0500
Date: Thu, 6 Nov 2003 18:06:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jbarnes@sgi.com, willy@debian.org
Subject: Re: [DMESG] cpumask_t in action
Message-Id: <20031106180628.0836b12b.pj@sgi.com>
In-Reply-To: <20031106203114.GA22338@mandrake.americas.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F3751@scsmsx401.sc.intel.com>
	<20031106203114.GA22338@mandrake.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The BogoMIPS is another which I would think could be eliminated unless
> it is significantly different from the boot cpu.  Maybe say greater
> than 10% different.

Or just show the min and max:

  BogoMIPS for 64 CPUs range from 2241.08 to 2298.56

If someone knows they have 32 CPUs at 1.1 GHz, and 32 CPUs at 1.3 GHz,
they don't need to see 32 of these listed as >10% out of spec.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
