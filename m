Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310422AbSCBTBp>; Sat, 2 Mar 2002 14:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310423AbSCBTBf>; Sat, 2 Mar 2002 14:01:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8979 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310422AbSCBTB0>; Sat, 2 Mar 2002 14:01:26 -0500
Subject: Re: Network Security hole (was -> Re: arp bug )
To: erich@uruk.org
Date: Sat, 2 Mar 2002 19:14:55 +0000 (GMT)
Cc: ja@ssi.bg (Julian Anastasov), szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16hESa-0000Gn-00@trillium-hollow.org> from "erich@uruk.org" at Mar 02, 2002 10:42:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hEy7-000875-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's say you have a firewall running Linux.  Oops, I can spoof the
> external interface to accept traffic as if it's the internal one.

ARP is irrelevant to security. You don't need the ARP layer to do any
attacks or routing at all. There are a million ways to get the mac
address of a box.

> I.e. the machine still may be accepting traffic destined for one
> interface on another, even though it won't *advertise* that fact
> any more.

Its supposed to accept any packet for that system.  Thats correct behaviour
for the system.

Thats why you can have firewall rules. You'll find the standard Red Hat firewall
config tool sets up interface based rule sets. In fact in general rules should be
interface not address based.

Alan
