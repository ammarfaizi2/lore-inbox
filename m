Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSCKTti>; Mon, 11 Mar 2002 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSCKTta>; Mon, 11 Mar 2002 14:49:30 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29875 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290965AbSCKTsy>; Mon, 11 Mar 2002 14:48:54 -0500
Date: Mon, 11 Mar 2002 12:48:43 -0700
Message-Id: <200203111948.g2BJmhs13326@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@redhat.com, whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <20020310.183033.67792009.davem@redhat.com>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
	<20020310.180456.91344522.davem@redhat.com>
	<20020310212210.A27870@redhat.com>
	<20020310.183033.67792009.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Sun, 10 Mar 2002 21:22:10 -0500
>    
>    That's my fault.  The version of the driver in the kernel atm sucks in 
>    performance; I'll try to spend the day needed on the driver this week 
>    and it should get up to ~800mbit from the current mess.  Getting NAPI 
>    in the kernel would help... ;-)
> 
> Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
> without NAPI, there is no reason other cards cannot go full speed as
> well.
> 
> NAPI is really only going to help with high packet rates not with
> thinks like raw bandwidth tests.

You're saying that people should just go and use jumbo frames? Isn't
that a problem for mixed 10/100/1000 LANs?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
