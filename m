Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbRF1EGY>; Thu, 28 Jun 2001 00:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbRF1EGO>; Thu, 28 Jun 2001 00:06:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58005 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265516AbRF1EGJ>;
	Thu, 28 Jun 2001 00:06:09 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.44330.558687.314786@pizda.ninka.net>
Date: Wed, 27 Jun 2001 21:06:02 -0700 (PDT)
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A2ABC.B9B4CEB6@vnet.ibm.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
	<3B3A5B00.9FF387C9@mandrakesoft.com>
	<20010628091704.B23627@krispykreme>
	<15162.33445.396761.71174@pizda.ninka.net>
	<3B3A2ABC.B9B4CEB6@vnet.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Gall writes:
 > "David S. Miller" wrote:
 > 
 > > Looks, ppc64 is really still experimental right?
 > 
 > Heck no.

So it is so stable that it isn't even merged into the mainline 2.4.x
sources? :-)

We're talking about a port which doesn't even exist in the mainline
sources yet.

 > > Which means it is
 > > 2.5.x material, and 2.5.x has been quoted as being a week or two away.
 > 
 > I sure hope that ppc64 is NOT considered 2.5.x material.

No, I'm saying that ppc64 with >=256 physical PCI busses, is 2.5.x
material.

 > A real solution would be nice. And if the real solution can ONLY be in 2.5, then
 > is it such a bad idea moving the bus number type to unsigned int for 2.4.x?

Yes, no kludges for 2.4.x

Look, I do not even feel for you.

I waited patiently for a sane PCI dma architecture so I could support
>4GB ram on 64-bit PCI systems (sparc64, alpha, etc.).  And it was
worth the wait, most of the important PCI drivers fully use this
interface, and it was all done properly.

Similarly you can wait for 2.5.x for >=256 physical PCI bus support.
Ok?

Later,
David S. Miller
davem@redhat.com
