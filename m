Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753814AbWKMCNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbWKMCNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbWKMCNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 21:13:52 -0500
Received: from mga06.intel.com ([134.134.136.21]:38819 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1753814AbWKMCNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 21:13:51 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,415,1157353200"; 
   d="scan'208"; a="160351384:sNHT18901995"
Date: Sun, 12 Nov 2006 17:50:51 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061112175050.A17720@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200611111620.24551.ak@suse.de>; from ak@suse.de on Sat, Nov 11, 2006 at 04:20:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 04:20:24PM +0100, Andi Kleen wrote:
> On Saturday 11 November 2006 16:14, Ingo Molnar wrote:
> > 
> >  - removed the CPU hotplug hacks, switching the default for small
> >    systems back from phys-flat to logical-flat. The switching to logical 
> >    flat mode on small systems fixed sporadic ethernet driver timeouts i 
> >    was getting on a dual-core Athlon64 system:
> 
> That will break CPU hotplug on some Intel systems (Ashok can give details) 

There is an issue of using clustered mode along with cpu hotplug. More details
are at the below link.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2

thanks,
suresh
