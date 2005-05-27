Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVE0HN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVE0HN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVE0HM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:12:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:2949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261921AbVE0HDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:03:10 -0400
Date: Fri, 27 May 2005 00:02:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com, shaohua.li@intel.com,
       ashok.raj@intel.com
Subject: Re: [Patch] x86: fix smp_num_siblings on buggy BIOSes
Message-Id: <20050527000215.0ac6a9eb.akpm@osdl.org>
In-Reply-To: <20050526233658.A28476@unix-os.sc.intel.com>
References: <20050525173456.A11038@unix-os.sc.intel.com>
	<20050526221737.7fc42984.akpm@osdl.org>
	<20050526233658.A28476@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> BTW, when do you plan to integrate x86 cpu hotplug patches to mainline?

I guess after the various subsystem trees have merged their stuff
post-2.6.12 (I tend to wait until after they've merged, although sometimes
people are slow and I get bored).  Say, 1-2 weeks after 2.6.12 is released.
And I'd guess 2.6.12 is 1-2 weeks away.

>  Depending on that I will plan my "smp_num_siblings" global cleanup.

gack, OK.  The kexec patches are a major source of x86 churn.  I don't know
if we'll be merging all the kexec stuff for 2.6.13.  Probably we will.

