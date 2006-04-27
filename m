Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWD0PlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWD0PlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWD0PlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:41:21 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:38059 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S965040AbWD0PlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:41:20 -0400
Mime-Version: 1.0
Message-Id: <a06230904c07687df0a33@[129.98.90.227]>
In-Reply-To: <20060427135119.GB5177@rama>
References: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu>
 <a06230901c075ca078b8d@[129.98.90.227]> <20060427135119.GB5177@rama>
Date: Thu, 27 Apr 2006 11:41:40 -0400
To: Harald Welte <laforge@netfilter.org>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: iptables is complaining with bogus unknown error
 18446744073709551615
Cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Apr 26, 2006 at 09:12:38PM -0400, Maurice Volaski wrote:
>>  Automatic kernel module loading! That is an option and it's off by
>>  default. When it's off, attempts to load kernel modules are ignored
>>  internally, and that's why iptables was failing. It tried to load
>>  xt_tcpudp, but was ignored by the kernel.
>
>What do you mean by "it's an option" and "is off by default".  I would
>claim that any major linux distribution that I've seen in the last ten
>years has support for module auto loading (enabled by default).
>

Distribution vendors are free to change it to whatever they want, I 
guess, but it's OFF by default in the official kernel (.config).
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
