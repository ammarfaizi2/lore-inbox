Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRA0WnV>; Sat, 27 Jan 2001 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRA0WnL>; Sat, 27 Jan 2001 17:43:11 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:19467 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130013AbRA0Wmz>;
	Sat, 27 Jan 2001 17:42:55 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101272242.f0RMgme376419@saturn.cs.uml.edu>
Subject: Re: Looking for comparison data on network stack prowess
To: david@linux.com (David Ford)
Date: Sat, 27 Jan 2001 17:42:48 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3A729F76.4A9170E6@linux.com> from "David Ford" at Jan 27, 2001 10:14:14 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:

> I'm looking for some authoritative comparisons and discussions of the
> current network stacks in *BSD and Linux.  I.e. NET4 in Linux and
> whatever is most current in *BSD.
>
> _PLEASE_ no flaming, no causing flamewar, nadda.
> 
> I am writing an article for Linux.com and I am attempting to debunk
> longstanding fallacies on both sides of the camp.  I am aiming for a

Start with the history: Net3 is not net3. Net2 is not net2.
Linux did not steal the BSD stack. I recall that Alan Cox
politely asked UCB to have it under the GPL, and was refused.

It amazes me how Linux can be accused of stealing BSD network
code while also being said to have poor network code... guess
that means we broke it?

Oh, BTW, BSD was _not_ the first OS with IP. The first was some
horrid mainframe thing. Sometimes, he who codes last codes best.

> truely neutral article which means I want to hear about the bad
> as well as the good for both camps.

Fair? Then this must be an equal-budget competition. SPECWeb99 is
just that, with "infinity" as the budget. I think it has to be noted
that BSDI has not accepted the challenge. That's just performance
though, which isn't a problem for most people.

I propose a feature and ease-of-use compatition. Each group gets
to suggest a few interesting routing and firewalling problems.
Maybe have a few Cisco and Microsoft fans try to stump us too.
Then each group tries to find a solution that is fast, reliable,
easy to understand, safe, easy to implement, and easy to maintain.
The use of non-standard tools and patches is tolerated, but it
greatly reduces your rank.

(solutions can be tossed into a HOWTO as well)

Example:
You have a home LAN with one fixed IP address on an ISDN line,
and another fixed IP address on a DSL line. You have domain names
that point to the ISDN line's IP, and you want to convert over
to using DSL exclusively. Connections initiated from outside ought
to go out the way they came in (with the right IP!), and connections
initiated from inside should go out the DSL line.

There are plenty of ways the groups could challenge each other:
PPPoE with dynamic IP assignment and decent firewall rules,
bridging all packets with a Cisco MAC address, IPv6-to-IPv4,
plain dial-on-demand into a strongly Microsoft-centric ISP,
VLANs, a VPN, AppleTalk and IPX support, ECN bit removal,
policy routing and bandwidth reservation...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
