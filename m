Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUIWQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUIWQlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWQkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:40:39 -0400
Received: from fmr04.intel.com ([143.183.121.6]:23017 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S268019AbUIWQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:39:08 -0400
Date: Thu, 23 Sep 2004 09:38:58 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/4] NUMA node handling support for ACPI container driver
Message-ID: <20040923093858.A12852@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094719.H14208@unix-os.sc.intel.com> <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Fri, Sep 24, 2004 at 01:23:01AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:23:01AM +0900, Keiichiro Tokunaga wrote:
> On Mon, 20 Sep 2004 09:47:19 -0700, Keshavamurthy Anil S wrote:
> > Changes from previous release:
> > 1) Typo fix- ACPI004 to ACPI0004
> > 2) Added depends on EXPERIMENTAL in Kconfig file
> > 
> > ---
> > Name:container_drv.patch
> > Status: Tested on 2.6.9-rc1
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Depends:	
> > Version: applies on 2.6.9-rc1
> > Description:
> > This is the very early version on the Container driver which supports
> > hotplug notifications on ACPI0004, PNP0A05 and PNP0A06 devices.
> > 	Changes from previous release:
> > 	1) Mergerd the typo fix patch which changes "ACPI004" to "ACPI0004"
> > ---
> 
> I have made a patchset to add 'NUMA node handling support' to
> your patchset.  If a container that is identical to NUMA node is
> hotplugged, this handles NUMA related stuffs.  For instance,
> creating/deleting sysfs directories and files of node, data structures,
> and etc...

Great!!! 
> 
>   - numa_hp_base.patch
>   - numa_hp_ia64.patch
>   - acpi_numa_hp.patch
>   - container_for_numa.patch
I will take a look at all of the above patches and will get back to you soon.
> 
> Status: Tested on 2.6.9-rc2 including your patchset posted earlier.
Sounds good.

thanks,
Anil Keshavamurthy
