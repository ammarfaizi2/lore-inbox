Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263530AbUJ2Wyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbUJ2Wyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbUJ2WxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:53:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:53168 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S263530AbUJ2Wul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:50:41 -0400
Message-ID: <4182C60C.2040600@osdl.org>
Date: Fri, 29 Oct 2004 15:37:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove duplicate includes (fwd)
References: <20041029214717.GW6677@stusta.de> <20041029222612.GI23841@redhat.com>
In-Reply-To: <20041029222612.GI23841@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 29, 2004 at 11:47:17PM +0200, Adrian Bunk wrote:
> 
>  > --- linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c.old	2004-10-22 21:37:33.000000000 +0200
>  > +++ linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c	2004-10-22 21:52:35.000000000 +0200
>  > @@ -26,7 +26,6 @@
>  >  #include <linux/kmod.h>
>  >  #include <linux/workqueue.h>
>  >  #include <linux/jiffies.h>
>  > -#include <linux/config.h>
>  >  #include <linux/kernel_stat.h>
>  >  #include <linux/percpu.h>
> 
> Not only was this duplicated, but its also unnecessary as
> there are no CONFIG_ options in that file.
> You may want to add that checking to your script too.

That's 'make configcheck'...

-- 
~Randy
