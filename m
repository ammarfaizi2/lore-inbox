Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRJDLjJ>; Thu, 4 Oct 2001 07:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273739AbRJDLi7>; Thu, 4 Oct 2001 07:38:59 -0400
Received: from imap.digitalme.com ([193.97.97.75]:28743 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S273729AbRJDLip>;
	Thu, 4 Oct 2001 07:38:45 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
From: "Trever L. Adams" <vichu@digitalme.com>
To: Magnus Redin <redin@ingate.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110040825.KAA12270@reaktor.lkpg.cendio.se>
In-Reply-To: <200110040825.KAA12270@reaktor.lkpg.cendio.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.03.20.06 (Preview Release)
Date: 04 Oct 2001 07:39:00 -0400
Message-Id: <1002195544.3137.10.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-04 at 04:25, Magnus Redin wrote:
> 
> Linus writes:
> > Note that the big question here is WHO CARES?
> 
> Everybody building firewalls, routers, high performance web servers
> and broadband content servers with a Linux kernel.
> Everyody having a 100 Mbit/s external connection. 
> 
> 100 Mbit/s access is not uncommon for broadband access, at least in
> Sweden. There are right now a few hundred thousand twisted pair Cat 5
> and 5E installations into peoples homes with 100 Mbit/s
> equipment. Most of them are right now throttled to 10 Mbit/s to save
> upstream bandwidth but that will change as soon as we get more TV
> channels on the broadband nets. Cat 5E cabling is specified to be able
> to get gigabit into the homes to minimise the risk of the cabling
> becoming worthless in 10 or 20 years.

For businesses in some parts of the country, this is also becoming more
common (though it is usually 10 Mbit/s.  I believe that this will become
more and more common.

I do not agree with Linus's concept that you are foolish to allow people
"untrusted direct access", in so far as it applies to "no one would/will
allow high speed connections their machines."  Linus, dial-up
connections may not be a thing of the past for years to come, but what
we call high-speed is indeed changing.  Let us not let Linux fall
behind.  (AirSwitch in Utah offers 10 Mbits/s to the home in at least
Utah County.)

As for the technical debate of how to do this load limiting or
performance enhancement... I say do what is best on technical grounds...
not on bad assumptions.  This may mean that the other set of patches
going around may be best, or it may mean Ingo's is best or maybe
something entirely different.  I personally do not know!

Trever Adams

