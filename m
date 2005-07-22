Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVGVHO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVGVHO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVGVHO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:14:59 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:33134 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261779AbVGVHO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:14:58 -0400
Message-ID: <42E09CF0.8060805@bigpond.net.au>
Date: Fri, 22 Jul 2005 17:14:56 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.3 for 2.6.12 and 2.6.13-rc3
References: <42DB4EEE.2020900@bigpond.net.au>
In-Reply-To: <42DB4EEE.2020900@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 22 Jul 2005 07:14:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version contains minor bug fixes and improvements to spa_no_frills 
> and zaphod schedulers including changes to the default configuration 
> parameters for zaphod that take into account the results of tests using 
> Con Kolivas's new (and very useful) interbench benchmark tool.
> 
> A patch from Plugsched-5.2.2 to PlugSched-5.2.3 for 2.6.12 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.2-to-5.2.3-for-2.6.12.patch?download> 
> 
> 
> and a full patch for 2.6.13-rc3 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.3-for-2.6.13-rc3.patch?download> 

and for 2.6.13-rc3-mm1 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.3-for-2.6.13-rc3-mm1.patch?download>

> 
> 
> Very Brief Documentation:
> 
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
> 
> cpusched=<scheduler>
> 
> to the boot command line where <scheduler> is one of: ingosched,
> nicksched, staircase, spa_no_frills or zaphod.  If you don't change the
> default when you build the kernel the default scheduler will be
> ingosched (which is the normal scheduler).
> 
> The scheduler in force on a running system can be determined by the
> contents of:
> 
> /proc/scheduler
> 
> Control parameters for the scheduler can be read/set via files in:
> 
> /sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
