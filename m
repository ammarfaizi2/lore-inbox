Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWCAChA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWCAChA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWCAChA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:37:00 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:62784 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964829AbWCACg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:36:59 -0500
Message-ID: <440508C9.6030701@bigpond.net.au>
Date: Wed, 01 Mar 2006 13:36:57 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <4404CF98.7020804@bigpond.net.au>
In-Reply-To: <4404CF98.7020804@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 1 Mar 2006 02:36:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version updates staircase scheduler to version 14.1 (thanks Con) 
> and includes the latest smpnice patches
> 
> A patch for 2.6.16-rc5 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16-rc5.patch?download> 
> 

and for 2.6.16-rc5-mm1 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16-rc5-mm1.patch?download>

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
> 
> Peter


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
