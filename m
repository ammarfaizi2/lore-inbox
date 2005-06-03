Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFCT1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFCT1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFCT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:27:36 -0400
Received: from fmr22.intel.com ([143.183.121.14]:16019 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261510AbVFCT1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:27:30 -0400
Date: Fri, 3 Jun 2005 12:26:41 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Dave Jones <davej@redhat.com>, YhLu <YhLu@tyan.com>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050603122641.A31139@unix-os.sc.intel.com>
References: <3174569B9743D511922F00A0C94314230A403970@TYANWEB> <20050602190350.GD18775@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050602190350.GD18775@redhat.com>; from davej@redhat.com on Thu, Jun 02, 2005 at 03:03:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:03:50PM -0400, Dave Jones wrote:
> On Thu, Jun 02, 2005 at 11:56:25AM -0700, YhLu wrote:
>  > Really?,  smp_num_siblings is global variable and initially is set 1.
> 
> Why shouldn't it be ? It would only make sense to make it
> non-global if we supported a configuration where different
> CPUs had different numbers of siblings, which we don't.
> (And I'm fairly sure that AMD/Intel don't/won't either)

It will help if someone uses "maxcpus" boot param or if someone
wants to disable/enable certain logical siblings using HOTPLUG.

That is conceptually more cleaner too. Will do it post 2.6.12.

thanks,
suresh
