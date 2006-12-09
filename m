Return-Path: <linux-kernel-owner+w=401wt.eu-S1758067AbWLIVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067AbWLIVlQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbWLIVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:41:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52391 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758067AbWLIVlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:41:15 -0500
Date: Sat, 9 Dec 2006 13:45:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org,
       akpm <akpm@osdl.org>, chrisw@sous-sol.org, rusty@rustcorp.com.au,
       jeremy@goop.org, zach@vmware.com
Subject: Re: [PATCH] no paravirt for X86_VOYAGER or X86_VISWS
Message-ID: <20061209214518.GW1397@sequoia.sous-sol.org>
References: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap (randy.dunlap@oracle.com) wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Since Voyager and Visual WS already define ARCH_SETUP,
> it looks like PARAVIRT shouldn't be offered for them.
> 
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Chris Wright <chrisw@sous-sol.org>
