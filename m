Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293440AbSCKBbi>; Sun, 10 Mar 2002 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293453AbSCKBb3>; Sun, 10 Mar 2002 20:31:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23824 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293440AbSCKBbU>;
	Sun, 10 Mar 2002 20:31:20 -0500
Message-ID: <3C8C08FC.DB0E882F@mandrakesoft.com>
Date: Sun, 10 Mar 2002 20:31:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: "David S. Miller" <davem@redhat.com>, laforge@gnumonks.org,
        skraw@ithnet.com, joe@tmsusa.com, linux-kernel@vger.kernel.org,
        elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <20020310163339.H16784@sunbeam.de.gnumonks.org>
		<20020310.164113.01028736.davem@redhat.com>
		<200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca>
		<20020310.170338.83978717.davem@redhat.com> <200203110114.g2B1EuG24994@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> David S. Miller writes:
> >    From: Richard Gooch <rgooch@ras.ucalgary.ca>
> >    Date: Sun, 10 Mar 2002 17:55:44 -0700
> >
> >    David S. Miller writes:
> >    > The hardware is not capable of doing it, due to bugs in the hw
> >    > checksum implementation of the sk98 chipset.  They aren't being
> >    > "slow" they just can't possibly implement it for you.
> >
> >    So what is currently the best combination of gige card/driver/cost?
> >    What do you recommend to the budget-conscious?
> >
> > I can only tell you what I know performance wise about cards,
> > and currently it looks like:
> >
> > 1) Intel E1000
> > 2) Tigon2, aka. Acenic
> > 3) SysKonnect sk98, but has broken TX checksums.  If it had
> >    working TX checksums it would be in 2nd place instead of Acenic.
> >    This hw bug is essentially why Acenics were used for all the
> >    TUX benchmarks runs instead of SysKonnect cards.
> > 4) Tigon3, aka. bcm57xx
> >
> > This may surprise some people, but frankly I think the Tigon3's PCI
> > dma engine is junk based upon my current knowledge of the card.  It is
> > always possible I may find out something new which kills this
> > perception I have of the card, but we'll see...
> 
> I note the Intel card is pretty expensive. What are these "Addtron"
> cards I see listed on www.pricewatch.com for US$36 ?Is that a
> supported card under another name?
> 
> > All the cards listed above have good GPL'd drivers available.
> 
> When is the E1000 driver going to be added to the kernel?

It's already in 2.5.

It will be added to 2.4.x after further testing and review in 2.5.x.

	Jeff



-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
