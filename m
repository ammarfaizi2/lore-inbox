Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVCXISk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVCXISk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVCXISk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:18:40 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:1423 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262431AbVCXISi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:18:38 -0500
Message-ID: <424277DB.5000504@candelatech.com>
Date: Thu, 24 Mar 2005 00:18:35 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennert Buytenhek <buytenh@wantstofly.org>
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
References: <42421FF2.7050501@candelatech.com> <20050324081003.GA23453@xi.wantstofly.org>
In-Reply-To: <20050324081003.GA23453@xi.wantstofly.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> On Wed, Mar 23, 2005 at 06:03:30PM -0800, Ben Greear wrote:
> 
> 
>>I have two 4-port e1000 NICs in the system, on a riser card.
> 
> 
> How is the riser card wired?  F.e. does it have a single edge
> connector, and provides two PCI slots, or does it have a tiny
> additional edge connector that routes REQ#/GNT#/INTx from a
> nearby PCI slot, etc.?

It has an edge connector, a full 64-bit ribbon connector, and
a 32-bit ribon connector.  As far as I can tell, there are no
shared signals.

It is made by Adex electronics, and is part number:  P/NPCITX3S1 884-335-185

I tried two different systems, and the problem is identical, so I believe
it is not a hardware manufacturing glitch.  It may be a hardware design
issue in either the riser or the motherboard.  Or a BIOS PCI irq mapping
problem...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

