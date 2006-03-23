Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWCXBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCXBBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWCXBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:01:23 -0500
Received: from fmr18.intel.com ([134.134.136.17]:3498 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751160AbWCXBBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:01:22 -0500
Date: Thu, 23 Mar 2006 15:53:19 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: 2.6.16-mm1: CONFIG_HOTPLUG_CPU compile error
Message-ID: <20060323235318.GA31130@linux-os.sc.intel.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060323234217.GG22727@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323234217.GG22727@stusta.de>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 24 Mar 2006 00:04:38.0487 (UTC) FILETIME=[8AC67E70:01C64ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 12:42:17AM +0100, Adrian Bunk wrote:
> arch/i386/kernel/smpboot.c:1429: warning: implicit declaration of function '__smp_prepare_cpu'
> ...
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o: In function `__cpu_up': undefined reference to `__smp_prepare_cpu'
> make: *** [.tmp_vmlinux1] Error 1
> 
yes,

apparently the one that was sent to andrew and i got a confirmation for -mm is different
from whats on the broken-out patches.

I sent an email about it this mornig, havent heard from andrew yet.



ashok
