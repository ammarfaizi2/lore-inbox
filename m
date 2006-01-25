Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWAYVso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWAYVso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWAYVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:48:44 -0500
Received: from fmr23.intel.com ([143.183.121.15]:12998 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932153AbWAYVsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:48:43 -0500
Date: Wed, 25 Jan 2006 13:48:03 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, ak@muc.de, linux-kernel@vger.kernel.org,
       kaos@sgi.com, randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-ID: <20060125134802.A32505@unix-os.sc.intel.com>
References: <20060125120253.A30999@unix-os.sc.intel.com> <20060125121317.478462fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060125121317.478462fc.akpm@osdl.org>; from akpm@osdl.org on Wed, Jan 25, 2006 at 12:13:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:13:17PM -0800, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> >  void __cpuinit mcheck_init(struct cpuinfo_x86 *c)
> >   {
> >  -	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
> >  +	static cpumask_t mce_cpus = CPU_MASK_NONE;
> 
> Should that be __cpuinitdata?

Yes.. i sent an updated one to Andrew, but missed replying to group.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
