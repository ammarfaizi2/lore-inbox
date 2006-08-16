Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWHPEuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWHPEuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWHPEuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:50:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750747AbWHPEuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:50:46 -0400
Date: Tue, 15 Aug 2006 21:47:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060815214718.00814767.akpm@osdl.org>
In-Reply-To: <20060815212455.c9fe1e34.pj@sgi.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 21:24:55 -0700
Paul Jackson <pj@sgi.com> wrote:

> Thanks for the cleanup patch resend, Suresh.
> 
> > Resending the new patch. Before patch had some issues for Andy and hence
> > dropped.
> > 
> > Andrew, Please add this to -mm. This patch is against 2.6.18-rc4.
> > There might be a small conflict while applying to -mm. Let me know if you
> > want a patch on top of -mm.
> > 
> > thanks,
> > suresh
> > 
> > --
> 
> I found the above patch commentary frustrating to read, as it told me
> very little, and teased me with reference to details that are left
> unsaid.
> 
> Can we work on this patch's opening text a bit more?

Believe it or not, I usually suffer in silence.

> 
> ..
>
> > + * cpu_power indicates the computing power of each sched group. This is
> > + * used for distributing the load between different sched groups
> > + * in a sched domain.
> 
> Thanks for explaining what cpu_power means.
>

Hope not.  To me, "computing power" means megaflops/sec, or Dhrystones
(don't ask) or whatever.  If that's what "cpu_power" is referring to then
the name is hopelessly ambiguous with peak joules/sec and a big renaming is
due.

