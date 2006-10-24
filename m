Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWJXWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWJXWxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWJXWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:53:40 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47492 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1422764AbWJXWxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:53:39 -0400
Date: Tue, 24 Oct 2006 18:52:22 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Message-ID: <20061024225222.GA7241@filer.fsl.cs.sunysb.edu>
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:33:08PM -0700, Lu, Yinghai wrote:
>  
> Clear the irq releated entries in irq_vector, irq_domain and vector_irq 
> instead of clearing irq_vector only. So when new irq is created, it 
> could get that vector.
> 
> Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>
> 
> --- linux-2.6/arch/x86_64/kernel/io_apic.c	2006-10-24
> 13:40:48.000000000 -0700
> +++ linux-2.6.xx/arch/x86_64/kernel/io_apic.c	2006-10-24
> 14:03:08.000000000 -0700
> @@ -716,6 +716,22 @@

Your patch got mangled up.

Josef "Jeff" Sipek.

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
