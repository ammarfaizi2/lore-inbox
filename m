Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLANGl>; Fri, 1 Dec 2000 08:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQLANGb>; Fri, 1 Dec 2000 08:06:31 -0500
Received: from nas1-12.kmp.club-internet.fr ([213.44.17.12]:45551 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129345AbQLANGP>;
	Fri, 1 Dec 2000 08:06:15 -0500
Message-Id: <200012011230.NAA04009@microsoft.com>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
From: Xavier Bestel <xavier.bestel@free.fr>
To: Christoph Hellwig <hch@caldera.de>
Cc: cw@f00f.org, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com, romieu@ensta.fr
In-Reply-To: <200012011100.MAA14789@ns.caldera.de>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 01 Dec 2000 11:30:33 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <20001201233227.A9457@metastasis.f00f.org> you wrote:
> > Actually; Ethernet badly needs something like this too. I would kill
> > to be able to do something like:
> 
> >     ifconfig eth0 speed 100 duplex full
> 
> > o across different networks cards -- I've been thinking about it of
> > late as I had to battle with this earlier this week; depending on
> > what network card you use, you need different magic incarnations to
> > do the above.
> 
> > A standard interface is really needed; unless anyone objects I may
> > look at drafting something up -- but it will require some input if it
> > is not to look completely Ethernet centric.
> 
> For ethernet we have ethtool, recently changed from sparc only to
> architecture independend.

It should be consistent with the wireless extentions (same goal)

Xav
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
