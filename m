Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264092AbRFNVtC>; Thu, 14 Jun 2001 17:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRFNVsr>; Thu, 14 Jun 2001 17:48:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24756 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264092AbRFNVs3>;
	Thu, 14 Jun 2001 17:48:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.12584.339783.786454@pizda.ninka.net>
Date: Thu, 14 Jun 2001 14:48:24 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B2930B1.3E082883@mandrakesoft.com>
In-Reply-To: <15145.6960.267459.725096@pizda.ninka.net>
	<20010614213021.3814@smtp.wanadoo.fr>
	<3B2930B1.3E082883@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > I think rth requested pci_ioremap also...

It really isn't needed, and I understand why Linus didn't like the
idea either.  Because you can encode the bus etc. info into the
resource addresses themselves.

On sparc64 we just so happen to stick raw physical addresses into the
resources, but that is just one way of implementing it.

Later,
David S. Miller
davem@redhat.com
