Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRAGNrT>; Sun, 7 Jan 2001 08:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132095AbRAGNrJ>; Sun, 7 Jan 2001 08:47:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132039AbRAGNq7>; Sun, 7 Jan 2001 08:46:59 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: davem@redhat.com (David S. Miller)
Date: Sun, 7 Jan 2001 13:47:57 +0000 (GMT)
Cc: hadi@cyberus.ca, ak@suse.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <200101070543.VAA24689@pizda.ninka.net> from "David S. Miller" at Jan 06, 2001 09:43:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGAx-0002es-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    thing so that some stupid program that depends on ifconfig look and feel
>    would be a good start.
> 
> I could not agree more.  This reminds me to do something I could not
> justify before, making netlink be enabled in the kernel and
> non-configurable.

Why. Its bad enough that the networking layer doesnt let you configure out
stuff like SACK and the big routing hashes. Please don't make it even worse
for the embedded world. 99.9% of Linux boxes probably have less than 5 routing
table entries

> I could almost, but not quite, justify it right now just because "ip"
> is becomming standard and needs it.

ip is also not the smallest and simplest of binaries. You can fit an ifconfig
for ip in about 24K
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
