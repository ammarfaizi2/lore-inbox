Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310489AbSCCAjj>; Sat, 2 Mar 2002 19:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310490AbSCCAj2>; Sat, 2 Mar 2002 19:39:28 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:9738 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310489AbSCCAjO>;
	Sat, 2 Mar 2002 19:39:14 -0500
Date: Sun, 3 Mar 2002 02:38:36 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: erich@uruk.org, Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug )
In-Reply-To: <E16hIuK-0000Mv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203030222540.16710-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002, Alan Cox wrote:

> Language confusion - "if you want to make the case" = "if you want to argue
> that a value of rp_filter = 2 should in future (after you implement it) mean
> apply a both way rule - then I agree)

	Yes, the arp_prefsrc feature can depend on rp_filter||arp_filter
but I prefer to keep it independent. And there is an agreement on netdev
that all ARP filtering issues (including the problem with shared IPs
in clusters) should be fixed by maintaining ARP hooks for universal
filtering. Then even the arp_prefsrc feature can be implemented with
proper rules. TODO. Until then, this is a temp solution.

> Alan

Regards

--
Julian Anastasov <ja@ssi.bg>

