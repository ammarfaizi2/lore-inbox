Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRBZFbz>; Mon, 26 Feb 2001 00:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBZFbq>; Mon, 26 Feb 2001 00:31:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41880 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130155AbRBZFbX>;
	Mon, 26 Feb 2001 00:31:23 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15001.59778.748224.602042@pizda.ninka.net>
Date: Sun, 25 Feb 2001 21:28:34 -0800 (PST)
To: Chris Wedgwood <cw@f00f.org>
Cc: Jan Rekorajski <baggins@sith.mimuw.edu.pl>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy BETA 3
In-Reply-To: <20010225163836.A12173@metastasis.f00f.org>
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net>
	<20010223114249.A27608@sith.mimuw.edu.pl>
	<20010225163836.A12173@metastasis.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > --- linux-2.4.2/include/net/ip.h	Sun Feb 25 01:15:19 2001
 > +++ linux-2.4.2+zc-2/include/net/ip.h	Sun Feb 25 01:53:52 2001

You need to part that adds "id" to the sock struct too.
This won't build "as-is".

Besides, I'd like people to have to test the zerocopy stuff
for me, they'll get the ID fix if they do that :-)

Later,
David S. Miller
davem@redhat.com
