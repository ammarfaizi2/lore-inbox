Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273317AbRINGZL>; Fri, 14 Sep 2001 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273316AbRINGZB>; Fri, 14 Sep 2001 02:25:01 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:27658 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S273317AbRINGYy>;
	Fri, 14 Sep 2001 02:24:54 -0400
Date: Fri, 14 Sep 2001 00:12:03 -0600
From: Val Henson <val@nmt.edu>
To: Tom Rini <trini@kernel.crashing.org>, jgarzik@mandrakesoft.com,
        becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010914001201.A2951@boardwalk>
In-Reply-To: <20010913195141.B799@boardwalk> <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net> <20010913205459.A1169@boardwalk> <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net> <20010913220118.A647@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913220118.A647@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Thu, Sep 13, 2001 at 10:01:18PM -0700
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 10:01:18PM -0700, Matthew Dharm wrote:
> I would agree that listing them under the highest capable is probably the
> best.  It is, at least, consistent with the 10/100 cards.

I'm interested to hear why you think this is better than listing the
card under both of the 100 and 1000 Mbit categories (as the patch I
sent does it).  Also, we are not talking about one 10/100/1000 card,
we are talking about one driver that supports two separate cards, one
10/100/1000 and one 10/100.

-VAL

> Also, people will pick up the card, think "gigabit ethernet", and then look
> under the 1000 section.  I don't think anyone will really think GigE and
> then look under 10/100.
> 
> The Intel 82543 and 82544 gigabit parts are all 10/100/1000 -- I'll be
> writing a driver for those in a few weeks if nobody beats me to it, so I
> think it would be good to settle this.
> 
> Matt
> 
> On Thu, Sep 13, 2001 at 08:02:37PM -0700, Tom Rini wrote:
> > On Thu, Sep 13, 2001 at 08:55:01PM -0600, Val Henson wrote:
> > > On Thu, Sep 13, 2001 at 07:39:37PM -0700, Tom Rini wrote:
> > > > On Thu, Sep 13, 2001 at 07:51:41PM -0600, Val Henson wrote:
> > > > > -      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
> > > > > +      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_YELLOWFIN
> > > > 
> > > > Since you're killing this, why not just remove this question entirely?
> > > 
> > > This is one of the "design decisions" I referred to.  It makes no
> > > sense to list a 100 Mbit driver under "Ethernet (1000 Mbit)".  This is
> > > my solution.  This is the first case of a dual 1000/100 Mbit driver
> > > and if there's a better way to handle it I'd like to hear it.
> > 
> > Er, sungem does 10/100/1000 too I think.. (It's what's in the new G4
> > towers..).  IMHO, listing it once under the greatest makes sense.  But
> > sungem/gmac are under 10/100 I think.
> > 
> > -- 
> > Tom Rini (TR1265)
> > http://gate.crashing.org/~trini/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net 
> Maintainer, Linux USB Mass Storage Driver
> 
> C:  They kicked your ass, didn't they?
> S:  They were cheating!
> 					-- The Chief and Stef
> User Friendly, 11/19/1997


