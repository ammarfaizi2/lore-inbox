Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265494AbRF1DJW>; Wed, 27 Jun 2001 23:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265496AbRF1DJM>; Wed, 27 Jun 2001 23:09:12 -0400
Received: from [32.97.182.101] ([32.97.182.101]:47514 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265494AbRF1DJF>;
	Wed, 27 Jun 2001 23:09:05 -0400
Message-ID: <3B3A2ABC.B9B4CEB6@vnet.ibm.com>
Date: Wed, 27 Jun 2001 13:49:33 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
		<3B3A5B00.9FF387C9@mandrakesoft.com>
		<20010628091704.B23627@krispykreme> <15162.33445.396761.71174@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"David S. Miller" wrote:

> Looks, ppc64 is really still experimental right?

Heck no.

> Which means it is
> 2.5.x material, and 2.5.x has been quoted as being a week or two away.

I sure hope that ppc64 is NOT considered 2.5.x material.

> So we can solve this problem for real, with system bus domains, and
> get ppc64 working all within the framework of 2.5.x which is just
> around the corner.

A real solution would be nice. And if the real solution can ONLY be in 2.5, then
is it such a bad idea moving the bus number type to unsigned int for 2.4.x?

> For now, I am rather sure your systems for testing have < 256 physical
> PCI busses and you can for 2.4.x use the remapping scheme sparc64 uses.

Wellll, remember that post about more than 256 PCI buses? I meant it.

Regards,

Tom
--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


