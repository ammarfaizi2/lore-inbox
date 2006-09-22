Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWIVIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWIVIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIVIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:16:26 -0400
Received: from mx10.go2.pl ([193.17.41.74]:28315 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932070AbWIVIQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:16:24 -0400
Date: Fri, 22 Sep 2006 10:20:31 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 7179] New: Compilation of .tmp_linux1 fails due to missing declaration in net/netfilter/xt_physdev.c
Message-ID: <20060922082031.GA6820@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922080310.GA1012@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry linux-kernel - it should go to netdev.


On 22-09-2006 10:03, Jarek Poplawski wrote:
> On 22-09-2006 00:37, Andrew Morton wrote:
>> Methinks CONFIG_NETFILTER_XT_TARGET_CLASSIFY should depend upon
>> CONFIG_BRIDGE_NETFILTER.  Because brnf_deferred_hooks is defined in
>> net/bridge/br_netfilter.c and is referred to in net/netfilter/xt_physdev.c.
>>
>> Or something else ;)
> 
> From net/netfilter/Kconfig:
> 
> config NETFILTER_XT_MATCH_PHYSDEV
>         tristate '"physdev" match support'
>         depends on NETFILTER_XTABLES && BRIDGE_NETFILTER
> 
> so "properly" generated .config should be enough.
> 
> Jarek P.
> 
> PS: I've just checked and it compiles OK. 



