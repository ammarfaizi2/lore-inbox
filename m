Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWD1SoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWD1SoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWD1SoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:44:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14818 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751437AbWD1SoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:44:02 -0400
Date: Fri, 28 Apr 2006 14:43:49 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, ebiederm@xmission.com,
       nanhai.zou@intel.com
Subject: Re: [Lhms-devel] Re: [PATCH] register hot-added memory to iomem resource
Message-ID: <20060428184349.GA28994@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com> <20060427160130.6149550f.akpm@osdl.org> <20060428092754.cf382d03.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428092754.cf382d03.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 09:27:54AM +0900, KAMEZAWA Hiroyuki wrote:
> > And how is kdump to know that memory was hot-added?  Do we generate a
> > hotplug event?
> > 
> A user program has to make memory section online from sysfs , anyway.
> 
> The hotplug script for memory hotplug will run at memory hotplug event 
> from ACPI. If a user uses /probe interface (powerpc, x86_64),
> he knows what he does. 
> 
> hot-add -> online memory -> kexec_load() is a scenario I think of.
> 

Did a quick search but can't locate a memory hotplug agent. Can you give
some pointers.

Thanks
Vivek
