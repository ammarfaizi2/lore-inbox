Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRKHBUe>; Wed, 7 Nov 2001 20:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKHBUZ>; Wed, 7 Nov 2001 20:20:25 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:47112 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S281228AbRKHBUN>; Wed, 7 Nov 2001 20:20:13 -0500
Date: Thu, 8 Nov 2001 02:20:02 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "David S. Miller" <davem@redhat.com>
cc: <adilger@turbolabs.com>, <jgarzik@mandrakesoft.com>, <andrewm@uow.edu.au>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <netdev@oss.sgi.com>, <ak@muc.de>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <20011107.170940.10246156.davem@redhat.com>
Message-ID: <Pine.LNX.4.30.0111080216250.30014-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>    --- linux-2.4.14/net/ipv4/ipconfig.c	Wed Oct 31 00:08:12 2001
>    +++ linux-2.4.14-jiffies64/net/ipv4/ipconfig.c	Wed Nov  7 23:28:47 2001
>
> These cases are indeed buggy.  I'd rather fix these ones with
> time_{after,before}() though.  And again, your "signed" casts
> are totally superfluous.
>

They actually are necessary as unsigned values can never become less than
zero.

Tim

