Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbQLALbw>; Fri, 1 Dec 2000 06:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQLALbm>; Fri, 1 Dec 2000 06:31:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:12049 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129639AbQLALbh>;
	Fri, 1 Dec 2000 06:31:37 -0500
Date: Fri, 1 Dec 2000 12:00:06 +0100
Message-Id: <200012011100.MAA14789@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: cw@f00f.org (Chris Wedgwood)
Cc: Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, romieu@ensta.fr
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20001201233227.A9457@metastasis.f00f.org>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001201233227.A9457@metastasis.f00f.org> you wrote:
> Actually; Ethernet badly needs something like this too. I would kill
> to be able to do something like:

> 	ifconfig eth0 speed 100 duplex full

> o across different networks cards -- I've been thinking about it of
> late as I had to battle with this earlier this week; depending on
> what network card you use, you need different magic incarnations to
> do the above.

> A standard interface is really needed; unless anyone objects I may
> look at drafting something up -- but it will require some input if it
> is not to look completely Ethernet centric.

For ethernet we have ethtool, recently changed from sparc only to
architecture independend.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
