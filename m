Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQLNLUq>; Thu, 14 Dec 2000 06:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132175AbQLNLUf>; Thu, 14 Dec 2000 06:20:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129828AbQLNLUV>; Thu, 14 Dec 2000 06:20:21 -0500
Subject: Re: do NOT compile 2.2.18 with egcs-1.1.2
To: jamagallon@able.es (J . A . Magallon)
Date: Thu, 14 Dec 2000 10:51:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dmircea@linux.kappa.ro (Mircea Damian), linux-kernel@vger.kernel.org
In-Reply-To: <20001214113813.C9662@werewolf.able.es> from "J . A . Magallon" at Dec 14, 2000 11:38:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146Vys-00047u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use 2.2.18 with ne2k-pci from kernel and that of scyld, and work fine under
> 2.91 (egcs)
> 
> BTW, when a resync of 2.2 net drivers with scyld ? perhaps 2.2.19 ? 

I have no plan to do this. Don's drivers depend on some extra glue that was
rejected from the main kernel tree. Said glue is also buggy causing the same
card to be multiply detected.

If folks want to strip the glue out and get real changes into the tree or
clean up a given driver then go ahead. (natsemi and the via-rhine updates
would be nice for example).

Don't ask Donald to do it. He isnt hiding from us all, he's very busy doing
a lot of other cool stuff...

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
