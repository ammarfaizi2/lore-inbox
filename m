Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRFKAxo>; Sun, 10 Jun 2001 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbRFKAxd>; Sun, 10 Jun 2001 20:53:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18575 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263344AbRFKAxZ>;
	Sun, 10 Jun 2001 20:53:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15140.5762.589629.252904@pizda.ninka.net>
Date: Sun, 10 Jun 2001 17:53:22 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
In-Reply-To: <20010610093838.A13074@flint.arm.linux.org.uk>
	<Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
	<20010610173419.B13164@flint.arm.linux.org.uk>
	<3B23A4BB.7B4567A3@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > > [note I've not found anything in 2.4.5 where netif_carrier_ok prevents
 > > the net layers queueing packets for an interface, and forwarding them
 > > on for transmission].
 > 
 > we want netif_carrier_{on,off} to emit netlink messages.  I don't know
 > how DaveM would feel about such getting implemented in 2.4.x though,
 > even if well tested.

If someone sent me patches which did this (and minded the
restrictions, if any, this adds to the execution contexts in
which the carrier on/off stuff can be invoked) I would consider
the patch seriously for 2.4.x

Later,
David S. Miller
davem@redhat.com
