Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269974AbRHJTSM>; Fri, 10 Aug 2001 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHJTSC>; Fri, 10 Aug 2001 15:18:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3287 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269974AbRHJTR7>;
	Fri, 10 Aug 2001 15:17:59 -0400
Date: Fri, 10 Aug 2001 15:18:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writes to mounted devices containing file-systems.
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0108101503250.28666-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2001, Richard B. Johnson wrote:

> One of my file-servers was destroyed by an in-house hacker,
> (consultant) rented by our alleged Chief Information Officer,
> to destroy Linux systems and thereby show that they can't
> be used in a "professional" environment.

Adminned by clueless luser? I have to agree.

> I have about 20 megabytes of logs showing the machine being
> attacked from inside our firewall. Each time an attack occurred,
> I would firewall-out its phony IP address (ipchains). A few hours
> later the cycle repeated with another phony IP address.

Instead of trying to see WTF was going on and fixing the problem instead
of symptoms? _Real_ smart... Or, at least, block everything except the boxen
that have any business accessing it? You know, with explicit "accept" rules
in the beginning of the chain with catch-all "reject" after them...

> The exploit used multiple calls to get the system time, followed
> by an attempt to mount a file-system. Apparently the exploit
> eventually works because the system went down and the result was
> that the root file-system device, /dev/sda, was completely written
> with:
> 
> 	"S E C U R I T Y "
> 
> 8 Gb written with this 16-bytes pattern.

Secure your box and stop whining.  If attacker can gain root on a box
you admin - it's your bloody responsibility to fix the thing, firewalls
or not. Sheesh...

