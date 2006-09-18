Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWIRUQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWIRUQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWIRUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:16:21 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:45750 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751913AbWIRUQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:16:20 -0400
Subject: Re: [linux-pm] PowerOP vs OPpoint
From: Jon Loeliger <jdl@freescale.com>
To: Matthew Locke <matthew.a.locke@comcast.net>
Cc: pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <ff355e0e9a7ba8350241ffe483c664ab@comcast.net>
References: <ff355e0e9a7ba8350241ffe483c664ab@comcast.net>
Content-Type: text/plain
Message-Id: <1158610046.6962.186.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Date: Mon, 18 Sep 2006 15:07:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 04:22, Matthew Locke wrote:
> Unfortunately, there are two efforts underway that makes this confusing 
> and I think require a bit more than the short summary requested.  A one 
> paragraph summary can't address the why and how.  This email briefly 
> describes the why and the differences.
> 
> There are two main reasons for both these efforts:
> - existing power management interfaces do not enable the power 
> management features on the latest SOC's used in embedded mobile  
> devices
> - existing power management interfaces do not provide the API necessary 
> to build power managers (userspace and/or kernel space) that optimize 
> power consumption to level required by embedded mobile devices

So does it make sense to re-unify these two patch-sets
into one common, more general patch-set first?  Might
it make sense to do so in small, incremental steps that
everyone can agree on as we go along?

For example, maybe the very first thing to do is define
some notion of general "operating point" that is a super-set
of the cpufreq definition.   If we can define that structure
maybe we can progress towards introducing and using it.

Totally side-step the kernel-user level stuff for a bit...
Totally side-step the suspend/resume issues for a bit...

Thanks,
jdl


