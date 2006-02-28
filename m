Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWB1BgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWB1BgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWB1BgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:36:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbWB1BgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:36:24 -0500
Date: Mon, 27 Feb 2006 17:34:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, yanmin.zhang@intel.com, davem@davemloft.net,
       paulus@samba.org, benh@kernel.crashing.org, wli@holomorphy.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, tony.luck@intel.com
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-Id: <20060227173449.26c79a44.akpm@osdl.org>
In-Reply-To: <1141022034.1256.44.camel@ymzhang-perf.sh.intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
	<20060224142844.77cbd484.akpm@osdl.org>
	<20060226230903.GA24422@localhost.localdomain>
	<1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
	<1141022034.1256.44.camel@ymzhang-perf.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
>
> > > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
>  > > > > mprotect. My patch against 2.6.16-rc3 enables this capability.
> 
>  Based on David's comments, I worked out a new patch against 2.6.16-rc4.
>  Thank David.
> 

Please always send an updated changelog when sending an updated patch. 
Otherwise I have to go trolling back through the email thread to find it,
then work out what needs to be changed.

> 
>  I tested it on i386/x86_64/ia64. Who could help test it on other
>  platforms, such like PPC64?

I can do that - please send me your test app?
