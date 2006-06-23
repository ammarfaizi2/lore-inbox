Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWFWMfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWFWMfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFWMfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:35:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49091 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932560AbWFWMfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:35:43 -0400
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Date: Fri, 23 Jun 2006 14:35:38 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20060514185023.A16695@unix-os.sc.intel.com>
In-Reply-To: <20060514185023.A16695@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231435.38496.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 03:50, Venkatesh Pallipadi wrote:
> 
> [Sorry if this is a duplicate. I tried sending this mail two days back and I don't
> see it on the mailing list yet. So, resending it.]
> 
> 
> 
> Intel now has support for Architectural Performance Monitoring Counters
> ( Refer to IA-32 Intel Architecture Software Developer's Manual
> http://www.intel.com/design/pentium4/manuals/253669.htm ). This
> feature is present starting from Intel Core Duo and Intel Core Solo processors.
> 
> What this means is, the performance monitoring counters and some performance
> monitoring events are now defined in an architectural way (using cpuid).
> And there will be no need to check for family/model etc for these architectural
> events.
> 
> Below is the patch to use this performance counters in nmi watchdog driver.
> Patch handles both i386 and x86-64 kernels.

FYI - i went back to this old patch again because I temporarily dropped
the NMI rework for 2.6.18. Please let me know if it misses any changes
that you added in later kernels (except for the merge with the newer
code base)

-Andi

