Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132257AbRAZPQe>; Fri, 26 Jan 2001 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbRAZPQY>; Fri, 26 Jan 2001 10:16:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40082 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132241AbRAZPQI>;
	Fri, 26 Jan 2001 10:16:08 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.37986.469902.496834@pizda.ninka.net>
Date: Fri, 26 Jan 2001 07:14:42 -0800 (PST)
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010126160342.B7096@pcep-jamie.cern.ch>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de>
	<Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk>
	<20010126154447.L3849@marowsky-bree.de>
	<20010126160342.B7096@pcep-jamie.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier writes:
 > Does ECN provide perceived benefits to the node using it?

Yes, endpoints and intermediate routers can tell the TCP sender about
congestion instead of TCP having to guess about it based upon observed
packet drop.

It is a major enhancement to performance over any WAN.

The endpoint based congestion notification happens _now_ if both
sides speak ECN.  The router based notification will be happening
in the near future as Cisco and others deploy ECN speaking versions of
their router software.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
