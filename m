Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310431AbSCLGUd>; Tue, 12 Mar 2002 01:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSCLGUY>; Tue, 12 Mar 2002 01:20:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46773 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310431AbSCLGUP>; Tue, 12 Mar 2002 01:20:15 -0500
Date: Mon, 11 Mar 2002 23:20:10 -0700
Message-Id: <200203120620.g2C6KAZ20691@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@redhat.com, whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <20020311.220425.51167805.davem@redhat.com>
In-Reply-To: <20020310212210.A27870@redhat.com>
	<20020310.183033.67792009.davem@redhat.com>
	<200203111948.g2BJmhs13326@vindaloo.ras.ucalgary.ca>
	<20020311.220425.51167805.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Richard Gooch <rgooch@ras.ucalgary.ca>
>    Date: Mon, 11 Mar 2002 12:48:43 -0700
> 
>    David S. Miller writes:
>    > NAPI is really only going to help with high packet rates not with
>    > thinks like raw bandwidth tests.
>    
>    You're saying that people should just go and use jumbo frames? Isn't
>    that a problem for mixed 10/100/1000 LANs?
> 
> No, I'm saying that the current situation is fine with most cards
> and most uses.
> 
> Ben pointed out that interrupt-mitigation challenged cards like the
> NatSemi do gain, but that is the only case I can imagine at this
> time.
> 
> Unless you have a card like the NatSemi (no interrupt mitigation) or
> your interfaces are being hit with 120,000 packets per second EACH,
> then NAPI is not going to be an explosive gain for you.
> 
> Look, we were able to get world records in web serving without NAPI,
> right? :-)

:-) I'd be happy to get near 1 Gb/s (800 Mb/s is acceptable) with a
cheap card and MTU=1500. Ben's message about his tweaks is
encouraging. Pity the P3 is so piss-poor.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
