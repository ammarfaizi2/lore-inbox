Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTFCRT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFCRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:19:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7296
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261196AbTFCRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:19:54 -0400
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lincoln Durey <lincoln@emperorlinux.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kent E Yoder <yoder1@us.ibm.com>,
       Burt Silverman <burts@us.ibm.com>, Bradford Jones <brad1@us.ibm.com>,
       Alexandre =?ISO-8859-1?Q?Tr=E9panier?= <atrepani@ca.ibm.com>,
       Ken Aaker <kdaaker@rchland.vnet.ibm.com>,
       Janice Girouard <girouard@us.ibm.com>, Robert Finn <finnr@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Martin List-Petersen <martin@list-petersen.dk>,
       Greg KH <greg@kroah.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Jon maddog Hall <maddog@li.org>
In-Reply-To: <1054658974.2382.4279.camel@tori>
References: <1054658974.2382.4279.camel@tori>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054658054.9359.49.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 17:34:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 17:49, Lincoln Durey wrote:
> As I gather more info, it becomes clear that the IBM T40 has a TCPA chip
> in it with a "white list" of _allowed_ cards.  Apparently IBM has made a
> _policy_ decision to disallow any wifi card not on the list. (more
> below).  In doing this they have (perhaps unknowingly) severely limited
> the usefulness of the entire T40 (and X31 by extension) laptop lines for
> the many users of the Linux OS on those IBM systems.  Surely this was
> not intentional....

It seems remarkably incompetent if so. 

Firstly IBM seem to claim the device supports mini-PCI but their public
details do not make it clear IBM only allow its use with certain
components so its not true mini-PCI - thats advertising and sales of
goods happy lawsuit time, and remarkably careless.

Secondly TCPA doesn't require such a restriction. A TCPA system can have
hardware whitelists so that the TCPA chip refuses to do any TCPA with
unknown devices present (since they may be hostile) but it doesn't have
to fail to boot in this case.

[The test is actually irrelevant not only because as you showed with the
 hot plug case you can swap it but because even without its been known
 since the mid 1970's how to get around that even though the 30 year old
 knowledge may now not be spoken in the USSA]

So either

1.	IBM got their TCPA horribly wrong
2.	IBM got some kind of alleged FCC restrictions horribly wrong since
you've shown its trivially possible to swap the card.

If IBM claimed the device supported mini-PCI and the slot only works
with certain devices - and that was not made clear - that you take it
up with the relevan business/advertising standards bodies.

I suspect theregister.co.uk would be very interested in the story too 8)

