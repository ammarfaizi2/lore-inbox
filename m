Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbRF1EW0>; Thu, 28 Jun 2001 00:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbRF1EWR>; Thu, 28 Jun 2001 00:22:17 -0400
Received: from [32.97.182.104] ([32.97.182.104]:20199 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265518AbRF1EWD>;
	Thu, 28 Jun 2001 00:22:03 -0400
Message-ID: <3B3A3BB5.22E2D78@vnet.ibm.com>
Date: Wed, 27 Jun 2001 15:01:58 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
		<3B3A5B00.9FF387C9@mandrakesoft.com>
		<20010628091704.B23627@krispykreme>
		<15162.33445.396761.71174@pizda.ninka.net>
		<3B3A2ABC.B9B4CEB6@vnet.ibm.com> <15162.44330.558687.314786@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"David S. Miller" wrote:

> Tom Gall writes:
>  > "David S. Miller" wrote:
>  >
>  > > Looks, ppc64 is really still experimental right?
>  >
>  > Heck no.
>
> So it is so stable that it isn't even merged into the mainline 2.4.x
> sources? :-)

Heh...

>
> We're talking about a port which doesn't even exist in the mainline
> sources yet.

Just about there...finger crossed, Maintainers willing, etc etc.

>  > > Which means it is
>  > > 2.5.x material, and 2.5.x has been quoted as being a week or two away.
>  >
>  > I sure hope that ppc64 is NOT considered 2.5.x material.
>
> No, I'm saying that ppc64 with >=256 physical PCI busses, is 2.5.x
> material.

Well, if that's what we gotta live with, then that's what we gotta live with. Viva la
2.5 then!

>  > A real solution would be nice. And if the real solution can ONLY be in 2.5, then
>  > is it such a bad idea moving the bus number type to unsigned int for 2.4.x?
>
> Yes, no kludges for 2.4.x

Understood and agreed.

> Look, I do not even feel for you.
>
> I waited patiently for a sane PCI dma architecture so I could support
> >4GB ram on 64-bit PCI systems (sparc64, alpha, etc.).  And it was
> worth the wait, most of the important PCI drivers fully use this
> interface, and it was all done properly.

Yeah and I understand and appreciate that just for the matter of the device driver
owners making sure they are inline with the new direction.

>
> Similarly you can wait for 2.5.x for >=256 physical PCI bus support.
> Ok?

Rather not, but if that's the decision, I'm happy to live by it. That why I posted this
as an RFC, and I appreciate everyone's time, patience and feedback.

Regards,

Tom

--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


