Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUHWMsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUHWMsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHWMsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:48:13 -0400
Received: from cpe.atm2-0-1041033.0x50a56002.bynxx14.customer.tele.dk ([80.165.96.2]:17064
	"EHLO mail.instadia.net") by vger.kernel.org with ESMTP
	id S263772AbUHWMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:48:06 -0400
Message-ID: <4129E782.3040409@fugmann.net>
Date: Mon, 23 Aug 2004 12:48:02 +0000
From: Anders Fugmann <afu@fugmann.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040808 Debian/1.7.2-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Hesse <mail@earthworm.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: v2.6.8.1 breaks tspc
References: <200408212303.05143.mail@earthworm.de> <200408221506.07883.mail@earthworm.de> <200408221743.22561.vda@port.imtp.ilyichevsk.odessa.ua> <200408221826.41842.mail@earthworm.de>
In-Reply-To: <200408221826.41842.mail@earthworm.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hesse wrote:
> On Sunday 22 August 2004 16:43, Denis Vlasenko wrote:
> 
>>Please try whether it works whan you do
>>"echo 0 > /proc/sys/net/ipv4/tcp_window_scaling"
> 
> 
> That helps. Thanks so far.
Any explanation of why this solution works?

I hate to blindly just disable window_scaling, just to make tspc work on 
2.6.8.1.

Is this a bug in the tscp program, netfilter or the tcp stack (or none 
of the mentioned)? One easy conclution is that some change were made 
between 2.6.7 and 2.6.8.1 which made tspc break - The question is which 
change and what other effect this change has.

Regards
Anders Fugmann




