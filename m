Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVKUGGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVKUGGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 01:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVKUGGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 01:06:42 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:57020 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932204AbVKUGGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 01:06:41 -0500
Message-ID: <438163EF.5020808@bigpond.net.au>
Date: Mon, 21 Nov 2005 17:06:39 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.4 for 2.6.14 and 2.6.15-rc1
References: <437819D3.4010104@bigpond.net.au>
In-Reply-To: <437819D3.4010104@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 21 Nov 2005 06:06:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version updates the staircase scheduler to Con's version and makes 
> modifications to the interactive bonus mechanisms in spa_ws and zaphod 
> to use interactive sleepiness instead of ordinary sleepiness.
> 
> A patch for 2.6.15-rc1 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.4-for-2.6.15-rc1.patch?download> 
> 
> 
> and a patch to upgrade the 6.1.3 version for 2.6.14 to 6.1.4 is
> available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.3-to-6.1.4-for-2.6.14.patch?download> 
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
> nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
> don't change the default when you build the kernel the default scheduler
> will be ingosched (which is the normal scheduler).
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

Patch for 2.6.15-rc2 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.4-for-2.6.15-rc2.patch?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
