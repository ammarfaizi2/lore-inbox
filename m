Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSFCX4z>; Mon, 3 Jun 2002 19:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSFCX4y>; Mon, 3 Jun 2002 19:56:54 -0400
Received: from ns.snowman.net ([63.80.4.34]:64269 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S315919AbSFCX4x>;
	Mon, 3 Jun 2002 19:56:53 -0400
From: nick@snowman.net
Date: Mon, 3 Jun 2002 19:56:34 -0400 (EDT)
To: Marcus Sundberg <marcus@ingate.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
In-Reply-To: <vewutgw4n1.fsf@inigo.ingate.se>
Message-ID: <Pine.LNX.4.21.0206031956150.8643-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least some gigabit ethernet hubs on the market.  How badly
does it handle collisions?
	Nick

On 3 Jun 2002, Marcus Sundberg wrote:

> Benjamin LaHaise <bcrl@redhat.com> writes:
> 
> > What version of ns83820.c are you using?  Version 0.17 of ns83820.c 
> > made significant improvements under load.  Other possibilities include 
> > cabling problems (watch the kernel logs for changes in link state).  
> > Try to find out where the packets are getting dropped by looking 
> > through /proc/net/snmp and other statistics counters in the kernel.
> 
> 0.17, but some more testing showed that the ns83820 actually works
> just fine during this test when using just crossover cables and
> running at gigabit speed. The original testing was done using
> 100Mbit hubs, so my guess would be that the 83820 chips (and/or
> driver) doesn't handle collisions too well (which I don't have a
> problem with, as afaik GE is always switched).
> 
> However the DFE-580TX problems remain regardless of using a hubbed
> or switched network.
> 
> (As booth eepro100 and tulip-based cards works fine with the hubs
> I'm quite certain there's nothing wrong with them.)
> 
> //Marcud
> -- 
> ---------------------------------------+--------------------------
>   Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
>  Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

