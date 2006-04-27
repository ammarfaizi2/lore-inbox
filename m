Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWD0UAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWD0UAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWD0UAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:00:08 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:25233 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S965058AbWD0UAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:00:07 -0400
Mime-Version: 1.0
Message-Id: <a0623090fc076d2fda538@[129.98.90.227]>
In-Reply-To: <20060427192430.GE21823@rama>
References: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu>
 <a06230901c075ca078b8d@[129.98.90.227]> <20060427135119.GB5177@rama>
 <a06230904c07687df0a33@[129.98.90.227]> <20060427192430.GE21823@rama>
Date: Thu, 27 Apr 2006 16:00:30 -0400
To: Harald Welte <laforge@netfilter.org>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: CONFIG_KMOD in x86_64/defconfig (was Re: iptables is
 complaining with bogus unknown error 18446744073709551615)
Cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Apr 27, 2006 at 11:41:40AM -0400, Maurice Volaski wrote:
>>  >On Wed, Apr 26, 2006 at 09:12:38PM -0400, Maurice Volaski wrote:
>>  >> Automatic kernel module loading! That is an option and it's off by
>>  >> default. When it's off, attempts to load kernel modules are ignored
>>  >> internally, and that's why iptables was failing. It tried to load
>>  >> xt_tcpudp, but was ignored by the kernel.
>>  >What do you mean by "it's an option" and "is off by default".  I would
>>  >claim that any major linux distribution that I've seen in the last ten
>>  >years has support for module auto loading (enabled by default).
>>
>>  Distribution vendors are free to change it to whatever they want, 
>>I guess, but it's OFF by
>>  default in the official kernel (.config).
>
>apparently architecture-specific:
>
>grep KMOD arch/i386/defconfig
>CONFIG_KMOD=y
>
>grep KMOD arch/x86_64/defconfig
>CONFIG_KMOD is not set
>
>don't know why x86_64 turns it off by default.  the help message says

A typo, perhaps? If so, won't be for much longer: 
http://bugzilla.kernel.org/show_bug.cgi?id=6451
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
