Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbRANI4R>; Sun, 14 Jan 2001 03:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131581AbRANI4H>; Sun, 14 Jan 2001 03:56:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60057 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131436AbRANIz4>;
	Sun, 14 Jan 2001 03:55:56 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.26991.35849.95234@pizda.ninka.net>
Date: Sun, 14 Jan 2001 00:55:11 -0800 (PST)
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <Pine.LNX.4.30.0101140948080.16388-100000@jdi.jdimedia.nl>
In-Reply-To: <20010114093623.M6055@coruscant.gnumonks.org>
	<Pine.LNX.4.30.0101140948080.16388-100000@jdi.jdimedia.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Igmar Palsenberg writes:
 > > > ./ip rule list
 > > > RTNETLINK answers: Invalid argument
 > > > Dump terminated
 > >
 > > You forgot to set CONFIG_IP_ADVANCED_ROUTER
 > 
 > Nope. Still the same error after that one is set :
 > 
 > CONFIG_IP_ADVANCED_ROUTER=y

Try CONFIG_IP_MULTIPLE_TABLES.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
