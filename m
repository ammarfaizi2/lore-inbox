Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTDTSbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTDTSbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:31:42 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:4823 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S263671AbTDTSbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:31:41 -0400
Message-ID: <3EA2E8CC.4080201@cox.net>
Date: Sun, 20 Apr 2003 11:37:00 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: irq balancing; kernel vs. userspace
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>	 <6uwuhpl2u5.fsf@zork.zork.net> <1050863476.1412.11.camel@laptop.fenrus.com>
In-Reply-To: <1050863476.1412.11.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> On Sun, 2003-04-20 at 15:23, Sean Neakums wrote:
> 
>>I thought I'd play with the userspace IRQ-balancer, but booting with
>>noirqbalance seems not to not balance.  Possibly I misunderstand how
>>this all fits together.
> 
> 
> this looks like you haven't started the userspace daemon (yet)

I thought the same thing reading his original message, then I looked 
closer. He booted using "noirqbalance", did not start the userspace 
balancer, and yet his IRQs are still being balanced.

