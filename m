Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273098AbRIRRnl>; Tue, 18 Sep 2001 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIRRnc>; Tue, 18 Sep 2001 13:43:32 -0400
Received: from [213.82.86.194] ([213.82.86.194]:39439 "EHLO fatamorgana.net")
	by vger.kernel.org with ESMTP id <S273098AbRIRRnP>;
	Tue, 18 Sep 2001 13:43:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roberto Arcomano <berto@fatamorgana.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proxy arp bug on shaper device
Date: Tue, 18 Sep 2001 19:46:58 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01091819465801.01127@berto.casa.it>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	If this is true then you have to provide support for all
> other devices, for example, tunnels.

Yes, unfortunately I tried but without success to extend patch to all that: I
need some info to do it (particolary I cannot understand how extract
"priv->dev" from a unknown device cause each (for each device) could be
different.....)

 The common for such setups is

> that asymmetric routing is used. OTOH, your change drops the ARP
> probe without updating the neighbour state. BTW, do you see any
> incoming traffic on the shaper device?

There should not be incoming traffic from shaper device (I never saw it).

Thank you for your help
Roberto Arcomano

> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>

-------------------------------------------------------
