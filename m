Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269300AbUIHSpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269300AbUIHSpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUIHSnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:43:20 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:11270 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S269304AbUIHSlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:41:40 -0400
Message-ID: <413F525E.3010408@optonline.net>
Date: Wed, 08 Sep 2004 14:41:34 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Stearns <wstearns@pobox.com>
CC: Ram Chandar <rcknl@qz.port5.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Routing Performance inferior?
References: <200409071000.58455.rchandar-knl@qz.port5.com> <Pine.LNX.4.58.0409081354470.2985@sparrow>
In-Reply-To: <Pine.LNX.4.58.0409081354470.2985@sparrow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Stearns wrote:
> Good afternoon, Ram,
> 
> On Wed, 8 Sep 2004, Ram Chandar wrote:
> 
> 
>>Quoted from a recent mail to freebsd mailing list.
>>
>>"FreeBSD (5.x) can route 1Mpps on a 2.8G Xeon while
>>Linux can't do much more than 100kpps"
>>
>>http://lists.freebsd.org/pipermail/freebsd-net/2004-September/004840.html
>>
>>Is this indeed the case?
> 
> 
> 	I'm sure others here have far better examples, but one post to the 
> netfilter-devel list last December provided an example of a firewall that 
> could process 580kpps with netfilter/conntrack turned off.  Granted, the 
> post noted that adding netfilter brought that down to 450kpps, and adding 
> conntrack on top of that brought it down to 295kpps, but all three of 
> those numbers are well over the claimed 100kpps.

Nonetheless, FreeBSD has some advantages. They achieved their results 
using a fast forwarding path (enabled via sysctl) that processes 
forwarded packets to completion entirely within the interrupt handler.
