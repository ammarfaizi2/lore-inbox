Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTIIU0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTIIUTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:19:42 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:53954 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S264497AbTIIURf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:17:35 -0400
Message-ID: <3F5E5137.2010902@telia.com>
Date: Wed, 10 Sep 2003 00:16:23 +0200
From: Miffe <miffe-miffe@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Lockups when booting with CardBus NIC inserted
References: <1063135080.1228.10.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1063135080.1228.10.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> Is anyone experiencing this?

Yes, in 2.6.0-test5.
It stops after

PCI: Enabling device 0000:00:03.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:00:03.0 [1028:00bb]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0098, PCI irq10
Socket status: 30000020


