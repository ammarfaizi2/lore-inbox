Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVDLABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVDLABE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDLABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:01:04 -0400
Received: from fmr21.intel.com ([143.183.121.13]:39647 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261730AbVDLABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:01:01 -0400
Date: Mon, 11 Apr 2005 17:00:24 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       discuss@x86-64.org, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [21/31] x86_64: Always use CPUID 80000008 to figure out MTRR address space size
Message-ID: <20050411170024.A3396@unix-os.sc.intel.com>
References: <425554EC.mailMV61WIBOM@suse.de> <20050410232523.B24470@unix-os.sc.intel.com> <20050411180001.GA27367@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050411180001.GA27367@wotan.suse.de>; from ak@suse.de on Mon, Apr 11, 2005 at 08:00:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:00:01PM +0200, Andi Kleen wrote:
> On Sun, Apr 10, 2005 at 11:25:23PM -0700, Siddha, Suresh B wrote:
> > We need to use the size_and_mask in set_mtrr_var_ranges(which is called 
> > while programming MTRR's for AP's
> 
> Patch is ok for me. But how did you find this out? Did you force
> a mapping high in the address space?

No. It was through code inspection.

thanks,
suresh
