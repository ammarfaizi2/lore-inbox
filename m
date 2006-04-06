Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWDFDfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWDFDfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDFDfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:35:16 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:58592 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751358AbWDFDfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:35:14 -0400
Message-ID: <44348C70.9050408@bigpond.net.au>
Date: Thu, 06 Apr 2006 13:35:12 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.2 for  2.6.17-rc1
References: <4431FB72.9030907@bigpond.net.au>
In-Reply-To: <4431FB72.9030907@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Apr 2006 03:35:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version updates staircase scheduler to version 15 (thanks Con)
> and includes the latest smpnice patches
> 
> A patch for 2.6.17-rc1 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.2-for-2.6.17-rc1.patch?download> 
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
> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
> or zaphod.  If you don't change the default when you build the kernel
> the default scheduler will be ingosched (which is the normal scheduler).
> 
> The scheduler in force on a running system can be determined by the
> contents of:
> 
> /proc/scheduler
> 
> Control parameters for the scheduler can be read/set via files in:
> 
> /sys/cpusched/<scheduler>/

Now available for 2.6.17-rc1-mm1 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.2-for-2.6.17-rc1-mm1.patch?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
