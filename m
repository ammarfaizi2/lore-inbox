Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUEFJzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUEFJzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUEFJzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:55:46 -0400
Received: from fmr03.intel.com ([143.183.121.5]:55503 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261947AbUEFJzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:55:43 -0400
Date: Thu, 6 May 2004 02:54:06 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       pj@sgi.com, rusty@rustycorp.com.au
Subject: Re: (resend-3) take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [6/7]
Message-ID: <20040506025406.A4010@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org> <20040505104739.A24549@unix-os.sc.intel.com> <20040505231350.1d8a3ea6.akpm@osdl.org> <20040506023239.A3664@unix-os.sc.intel.com> <20040506024530.5682acf4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506024530.5682acf4.akpm@osdl.org>; from akpm@osdl.org on Thu, May 06, 2004 at 02:45:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 02:45:30AM -0700, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > > I'll stick a CONFIG_SMP in the caller, let the bitmap beavers worry about
> > > the more general details.
> > Now under the protective covers of CONFIG_SMP, init/main.c compiles now
> 
> I already fixed it up, thanks.  With an incremental patch, which is very
> much preferred over a wholesale replacement.
> 
I will in future.

> > kernel/built-in.o(.text+0x144e4): In function `kthread_bind':
> > : undefined reference to `kthread_wait_task_inactive'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> There is no symbol `kthread_wait_task_inactive' in the tree.
> 

I think i put the experimental i386 hotplug patch, and that might have brought something 
with it.. i see the -mm compile clean now.

Cheers,
ashok
