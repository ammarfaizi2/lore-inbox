Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWELVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWELVsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWELVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:48:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44555 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932248AbWELVsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:48:19 -0400
Date: Fri, 12 May 2006 21:44:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060512214407.GB4189@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085157.908244000@sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- /dev/null
> +++ linus-2.6/drivers/xen/core/time.c
> @@ -0,0 +1,1045 @@
> +/*
> + *  time.c
> + *
> + *  Copyright (C) 1991, 1992, 1995  Linus Torvalds

Really?

> +void init_cpu_khz(void)
> +{
> +	u64 __cpu_khz = 1000000ULL << 32;
> +	struct vcpu_time_info *info;
> +	info = &HYPERVISOR_shared_info->vcpu_info[0].time;

No, I do not think linus wrote that. You probably want to add your
copyright there, and remove obsolete changelog.

-- 
Thanks for all the (sleeping) penguins.
