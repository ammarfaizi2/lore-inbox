Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVIWHF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIWHF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIWHF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:05:57 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:57175 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750718AbVIWHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:05:56 -0400
Message-ID: <4333A951.3060903@bigpond.net.au>
Date: Fri, 23 Sep 2005 17:05:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.1 for 2.6.13 and 2.6.13-mm2
References: <4323896F.5050703@bigpond.net.au>
In-Reply-To: <4323896F.5050703@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 23 Sep 2005 07:05:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version contains minor code cleanups and more modifications to the 
> spa_ws scheduler to improve its interactive responsiveness.  This 
> modification includes control parameters for the identification of 
> "media streaming" tasks.  The default values for these parameters are 
> set based on observations of RealPlayer and the parameters of the video 
> and audio benchmarks in Con Kolivas's interbench test and, therefore, 
> may need adjusting for other programs.
> 
> A patch for 2.6.13-mm2 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.1-for-2.6.13-mm2.patch?download> 
> 
> 
> and a patch to upgrade the 6.1 for 2.6.13 to 6.1.1 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1-to-6.1.1-for-2.6.13.patch?download> 
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
> nicksched, staircase, spa_no_frills, spa_ws or zaphod.  If you don't
> change the default when you build the kernel the default scheduler will
> be ingosched (which is the normal scheduler).
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

Patches for 2.6.14-rc2 and 2.6.14-rc2-mm1 are available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.1-for-2.6.14-rc2.patch?download>

and

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.1-for-2.6.14-rc2-mm1.patch?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
