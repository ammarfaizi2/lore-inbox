Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132095AbRAGNtJ>; Sun, 7 Jan 2001 08:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132173AbRAGNst>; Sun, 7 Jan 2001 08:48:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132095AbRAGNsn>; Sun, 7 Jan 2001 08:48:43 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: greearb@candelatech.com (Ben Greear)
Date: Sun, 7 Jan 2001 13:50:08 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), linux-kernel@vger.kernel.org (linux-kernel),
        netdev@oss.sgi.com (netdev@oss.sgi.com)
In-Reply-To: <3A580B31.7998C783@candelatech.com> from "Ben Greear" at Jan 06, 2001 11:22:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGD4-0002f7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Suppose I bind a raw socket to device vlan4001 (ie I have 4k in the list
> before that one!!).  Currently, that means a linear search on all devices,
> right?  In that extreme example, I would expect the hash to be very
> useful.

At this point you have to ask 'why is vlan4001 an interface'. Would it not
be cleaner to add the vlan id to the entries in the list of addresses per
interface ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
