Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVEZANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVEZANJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVEZANJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 20:13:09 -0400
Received: from fmr21.intel.com ([143.183.121.13]:50374 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261621AbVEZANG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 20:13:06 -0400
Date: Wed, 25 May 2005 17:11:55 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Ashok Raj <ashok.raj@intel.com>,
       ak@muc.de, akpm <akpm@osdl.org>, zwane <zwane@arm.linux.org.uk>,
       rusty@rustycorp.com.au, vatsa@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [patch 0/4] CPU Hotplug support for X86_64
Message-ID: <20050525171154.A10018@unix-os.sc.intel.com>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <1116927099.3827.2.camel@linux-hp.sh.intel.com> <4294F948.20004@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4294F948.20004@us.ibm.com>; from colpatch@us.ibm.com on Wed, May 25, 2005 at 03:16:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 03:16:40PM -0700, Matthew Dobson wrote:
> Shaohua Li wrote:
> > On Tue, 2005-05-24 at 01:11 -0700, Ashok Raj wrote:
> > 
> > With below patch, cpu hotplug works with SCHED_SMT enabled in my test.
> > set_cpu_sibling_map is invoked before cpu is set to online.
> > 
> > Thanks,
> > Shaohua
> 
> I'm not sure, but you probably want "for_each_cpu(i)" instead of "for (i =
> 0; i < NR_CPUS; i++)" below.
> 

I have a new set of patches just getting ready with final comments from Andi
This version already uses for_each_cpu varient.

Cheers,
ashok

