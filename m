Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVCXDZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVCXDZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCXDXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:23:37 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:28043 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S263001AbVCXDXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:23:04 -0500
Message-ID: <42423292.60701@candelatech.com>
Date: Wed, 23 Mar 2005 19:22:58 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
References: <42421FF2.7050501@candelatech.com>
In-Reply-To: <42421FF2.7050501@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> I'm having a strange problem.  I have an X6DVA motherboard
> with dual 2.8Ghz emt-64 processors, 1GB of RAM, SATA HD, etc.

> I tried kernel 2.6.11 which uses irq 26, and 2.6.10-1.770_FC2smp, which
> maps the irq to 209 or something like that.  Distribution is FC2, x86.
> Kernel is compiled for x86-SMP as well.
> 
> I suspect that this may be a hardware issue of some sort, but if anyone
> has any suggestions as to how to debug this further, please do let
> me know.  I'm attaching the lspci and dmesg output in case that helps.

I am now less certain:  I tried with a separate but similar machine, and
eth3 still has bad interrupt test.  I tried 2.6.9 kernel, same problem.
I tried 2.4.29 kernel (on FC2 distribution), and the same problem exists.

I tried with pci=noacpi, and this just messes up everything (irqs are
disabled, etc).

Could this be a bug in the motherboard implementation?

Off to try some different combinations of NIC hardware...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

