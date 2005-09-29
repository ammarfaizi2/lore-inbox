Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVI2NPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVI2NPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVI2NPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:15:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:16793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932105AbVI2NPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:15:31 -0400
Date: Thu, 29 Sep 2005 15:15:30 +0200
From: Andi Kleen <ak@suse.de>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       systemtap@sources.redhat.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: Re: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Message-ID: <20050929131530.GB5851@wotan.suse.de>
References: <8126E4F969BA254AB43EA03C59F44E84037185A6@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84037185A6@pdsmsx404>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 08:43:44AM +0800, Zhang, Yanmin wrote:
>  <<kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch>> I found it
> when reading the source codes. Basically, the bug could break
> kprobe_insn_pages under multi-thread environment. PPC arch also has the
> problem.

Can you describe what the problem actually is? 

-Andi

> Here is the patch against x86_64.
> 
> Signed-off-by: Zhang Yanmin <Yanmin.zhang@intel.com>
> 
> 


