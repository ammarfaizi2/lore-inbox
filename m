Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131333AbRAZRyM>; Fri, 26 Jan 2001 12:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbRAZRxx>; Fri, 26 Jan 2001 12:53:53 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:45713 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131333AbRAZRxv>; Fri, 26 Jan 2001 12:53:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 26 Jan 2001 09:53:49 -0800
Message-Id: <200101261753.JAA11559@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Cc: davem@redhat.com, hpa@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am surprised that anyone is seriously considering denying
service to sites that do not implement an _experimental_ facility
and have firewalls that try to play things safe by dropping packets
which have 1's in bit positions that in the RFC "must be zero."

	If Microsoft were to do this with their favorite experimental
network extensions for msnbc.com, how do you think the non-Microsoft
world would feel and react?  Well, that's about how the rest of
the world is likely to view this.

	That said, I wonder if some tweak to the Linux networking
stack is possible whereby it would automatically disable ECN and retry
on per socket basis if the connection establishment otherwise seems to
be timing out.  This may be tricky given that the purpose of this
facility is congestion notification, but, if someone is smart enough
to be able to implement this, it would provide a much less disruptive
migration path for adoption across firewalls that drop these packets.
Far more sites could then safely activate this feature without limiting
the hosts that they can reach.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
