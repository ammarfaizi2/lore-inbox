Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVBSGrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVBSGrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVBSGrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:47:17 -0500
Received: from oreo.zianet.com ([216.234.192.104]:36625 "EHLO oreo.zianet.com")
	by vger.kernel.org with ESMTP id S261644AbVBSGrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:47:13 -0500
X-Qmail-Scanner-Mail-From: kwijibo@zianet.com via oreo.zianet.com
X-Qmail-Scanner: 1.22 (Clear:RC:1(216.243.118.210):. Processed in 0.055922 secs)
Message-ID: <4216E043.1060507@zianet.com>
Date: Fri, 18 Feb 2005 23:44:19 -0700
From: Kwijibo <kwijibo@zianet.com>
Reply-To: kwijibo@zianet.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My guess is that irqbalance is not running.

Nigel Cunningham wrote:

>Hi all.
>
>I've noticed this problem for a while, but only now decided to ask.
>Interrupt balancing doesn't do anything on my system.
>
>           CPU0       CPU1
>  0:   31931808          0    IO-APIC-edge  timer
>  1:      76595          0    IO-APIC-edge  i8042
>  8:          1          0    IO-APIC-edge  rtc
>  9:          1          0   IO-APIC-level  acpi
> 14:        122          1    IO-APIC-edge  ide0
> 16:    4074456          0   IO-APIC-level  uhci_hcd, uhci_hcd, radeon@PCI:1:0:0
> 17:    4295132          0   IO-APIC-level  Intel ICH5
> 18:    2070933          0   IO-APIC-level  libata, uhci_hcd, eth0
> 19:     887311          0   IO-APIC-level  uhci_hcd
> 22:     572530          0   IO-APIC-level  ath0
>NMI:   31931749   31931636 (I've since disabled the nmi_watchdog)
>LOC:   31931252   31931251
>ERR:          0
>MIS:          0
>
>I enabled the debugging and found that it doesn't think it's worth the
>effort. Is that correct? Not a complaint, just curious!
>
>Regards,
>
>Nigel
>  
>

