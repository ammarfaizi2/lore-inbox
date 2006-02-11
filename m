Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWBKAvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWBKAvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBKAvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:51:33 -0500
Received: from fmr23.intel.com ([143.183.121.15]:15021 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750711AbWBKAvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:51:32 -0500
Date: Fri, 10 Feb 2006 16:51:27 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060210165127.A28881@unix-os.sc.intel.com>
References: <20060209095929.GZ4215@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060209095929.GZ4215@implementation.labri.fr>; from samuel.thibault@ens-lyon.org on Thu, Feb 09, 2006 at 10:59:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 10:59:29AM +0100, Samuel Thibault wrote:
> Hi,
> 
> Could cache-sharing multi-core chips be represented somehow in
> /proc/cpuinfo too? Such information can be useful in userspace too
> (without having to run cpuid & such). For instance:
> 
> physical id	: 0
> siblings	: 2
> l3 id		: 0
> l2 id		: 0
> core id		: 0
> cpu cores	: 2
> 
> etc.

/sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_map has this info
already

There is one more patch in works which enables exporting the multi-core
topology through sysfs

http://www.ussg.iu.edu/hypermail/linux/kernel/0601.3/0275.html

thanks,
suresh
