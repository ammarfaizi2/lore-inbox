Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVIUVoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVIUVoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVIUVoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:44:05 -0400
Received: from [203.171.93.254] ([203.171.93.254]:2478 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S965030AbVIUVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:44:04 -0400
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Li Shaohua <shaohua.li@intel.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
In-Reply-To: <43317F3E.9090207@yahoo.com.au>
References: <43317F3E.9090207@yahoo.com.au>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127338993.19156.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 22 Sep 2005 07:43:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick et al.

On Thu, 2005-09-22 at 01:41, Nick Piggin wrote:
> This patch should hopefully fix Nigel's bug.
> 
> Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
> and poll idle (previous iterations tested on various other architectures).
> 
> CCed Ian because I am amazed that arm26 ever managed to reschedule
> out of the idle task without this... what am I missing?
> 
> Andrew please apply

I'll give it a whirl when I get into work and let you know how I go.

Regards,

Nigel

