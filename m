Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136011AbRA1D2A>; Sat, 27 Jan 2001 22:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136695AbRA1D1t>; Sat, 27 Jan 2001 22:27:49 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:8164 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S136011AbRA1D1g>; Sat, 27 Jan 2001 22:27:36 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Gregory Maxwell" <greg@linuxpower.cx>
Cc: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: RE: hotmail not dealing with ECN
Date: Sat, 27 Jan 2001 19:27:34 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKEDMNFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010127190629.A7467@xi.linuxpower.cx>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, Jan 27, 2001 at 02:18:31PM -0800, David Schwartz wrote:

> > > Firewalling should be implemented on the hosts, perhaps with
> > > centralized
> > > policy management. In such a situation, there would be no
> > > reason to filter
> > > on funny IP options.

> > That's madness. If you have to implement your firewalling
> > on every host,
> > what do you do when someone wants to run a new OS? Forbid it?

> No a standard management interface would be followed by every host. Not
> unlike configuring your ipaddress with DHCP.

	How does a standard interface help?

	Perhaps you don't understand the problem -- someone wants to use a new
operating system that you no information about. You are willing to let it
run on your network if and only if you can be assured it won't violate your
firewall policy.

	So how does an interface guarantee that an unknown implementation of that
interface will correctly implement it? And what about printers? Embedded
systems? Legacy equipment? What about systems that have to run software that
isn't as trusted as the implementation of the firewalls has to be?

	The net effect of having to trust every host to enforce your security
policy is that you can't give anyone not trusted to enforce your security
policy root access on any machine on your network. Or, to put it another
way, you have to trust every machine on your network and every person who
controls them as much as you trust your firewall. That's simply unacceptable
in many applications.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
