Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136336AbRAGSaI>; Sun, 7 Jan 2001 13:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136343AbRAGS36>; Sun, 7 Jan 2001 13:29:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5648 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136336AbRAGS3s>; Sun, 7 Jan 2001 13:29:48 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: greearb@candelatech.com (Ben Greear)
Date: Sun, 7 Jan 2001 18:30:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3A58C3E8.FF5FF68E@candelatech.com> from "Ben Greear" at Jan 07, 2001 12:30:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FKat-00036O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats what it already does, if I understand correctly.  Of course, if VLAN
> is loaded as a module, then it will be in the hash before IP, right?

Thats fine. I think it'll be a different hash bucket anyway. The point of
having vlan first is that if its not registered or the interface isnt doing
vlan there is basically a zero overhead
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
