Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310491AbSCCAts>; Sat, 2 Mar 2002 19:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292574AbSCCAt2>; Sat, 2 Mar 2002 19:49:28 -0500
Received: from trillium-hollow.org ([209.180.166.89]:28607 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310491AbSCCAtH>; Sat, 2 Mar 2002 19:49:07 -0500
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sat, 02 Mar 2002 16:43:23 PST."
             <E16hK5z-0000vI-00@trillium-hollow.org> 
Date: Sat, 02 Mar 2002 16:49:05 -0800
From: erich@uruk.org
Message-Id: <E16hKBV-0000wK-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


erich@uruk.org wrote;

> > Linux 2.4 netfilter:
> > 
> > Incoming                                                 Outgoing
> > interface                                                interface
> >   ----+------------------- FORWARD -----------------+------->
> >       |                                             ^
> >       v                                             |
> >     INPUT -------------> Application -----------> OUTPUT
> > 
> > The names in capitals are the names of the tables.  You can control
> > packets that the local machine sees completely independently of what
> > gets routed through the machine with a kernel supporting iptables
> > by adding the appropriate rules to the input and forward tables.
> 
> Hmm.  This would seem to be false in the RH 7.2 kernel 2.4.9-21
> kernel I'm working with.
> 
> My IP masquerading rule (which claims to be in the "forward"
> chain, with target "MASQ"), was blocked when I did input address
> masking.
> 
> I.e. Yes, I actually tested this before posting.
> 
> If you're calling it a bug, then so be it.  But the result would be
> a bit better than how my Linux system works now.

Whoops, I am apparently using "ipchains" and not "iptables", and
didn't note the distinction.

Sorry about the spurious bug report here.  :/

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
