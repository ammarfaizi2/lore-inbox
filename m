Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273181AbRIJDdo>; Sun, 9 Sep 2001 23:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273184AbRIJDde>; Sun, 9 Sep 2001 23:33:34 -0400
Received: from oe39.law11.hotmail.com ([64.4.16.96]:49162 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273181AbRIJDdS>;
	Sun, 9 Sep 2001 23:33:18 -0400
X-Originating-IP: [142.179.28.112]
From: "David Grant" <davidgrant79@hotmail.com>
To: <jacob@chaos2.org>, "Joe Fago" <cfago@tconl.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0109091843220.31509-100000@inbetween.blorf.net>
Subject: Re: 2.4.9: PDC20267 not working
Date: Sun, 9 Sep 2001 20:30:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE39Zeh7UmNgW6VPMzP00004bf8@hotmail.com>
X-OriginalArrivalTime: 10 Sep 2001 03:33:34.0606 (UTC) FILETIME=[5ED072E0:01C139A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Jacob Luna Lundberg" <kernel@gnifty.net>
To: "Joe Fago" <cfago@tconl.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, September 09, 2001 6:46 PM
Subject: Re: 2.4.9: PDC20267 not working


>
> On Sun, 9 Sep 2001, Joe Fago wrote:
>
> > System hangs on boot:
>
> > PDC20267: IDE controller on PCI bus 00 dev 40
>
> > This is the only device attached to the controller. Any suggestions?
>
> I have seen this before.  I have a system that will do it every time right
> now, in fact.  You can try setting interrupts to edge-triggered in your
> BIOS if it has such an option; this usually ``fixes'' the problem for me.
> Of course, it will mean you can't share PCI interrupts, if I understand it
> correctly.  However, I'm not sure what's going on and nobody has commented
> on it thus far that I know of.  :(

Mine has problems as well.  I know there are workarounds, but I'm not
experienced enough to do these.  Joe: what error messages do you get?  I get
the "hde: timeout waiting for dma" errors.  After that I have to cold start
my PC to get it working.  BTW, I have a PDC20265, but I think these are
probably almost identical (or at least the behaviour we are getting is
probably due to the same problem in the code).

I also suspect that maybe what kind of hard drive you have makes a
difference as well, because some people can get their Promise IDE to work
fine, while others can't.  I have a Quantum Fireball Plus AS.

In case you didn't know, Andre Hedrick met with some dude from Promise
called Craig Lyons on Wednesday.  I haven't heard of any news from the
meeting, but supposedly Craig was going to give Andre some API for the
Ultra/Fastrack line of chips.  Hopefully it went down on Wednesday.

David Grant
