Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLDPIY>; Mon, 4 Dec 2000 10:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQLDPIO>; Mon, 4 Dec 2000 10:08:14 -0500
Received: from windsormachine.com ([206.48.122.28]:63236 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129410AbQLDPII>; Mon, 4 Dec 2000 10:08:08 -0500
Message-ID: <3A2BABC7.98725631@windsormachine.com>
Date: Mon, 04 Dec 2000 09:35:51 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA !NOT ONLY! for triton again...
In-Reply-To: <E142Wt2-00031c-00@f5.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the question is, can we trust a hard drive manufacturer support tech to know what they're talking about, with evidence to the contrary? :)

Somewhat like the 6 days i spent with a Cisco 802 and an 804, trying to get a link up.  Set it to National ISDN-1, dial 9 before dialing outbound number.  Connection comes up, but receive light is on, almost solid.  I figure I got the wrong switch type, so i give AT&T a call.  Bell tech comes out, finds out the line wasn't physically punched down into the block properly.

AT&T tells me it's a Northern DMS-100, and don't dial 9.  I set it up, can't get the connection to come up.  Invalid bear-caps.  I put the 9 back in, AT&T gives me a call, tells me to stop dialing 9.

Bell gets a call.  Turns out, it IS a National ISDN-1, and you're supposed to dial 9.  Seems that if you don't dial 9, it goes through AT&T's VOICE system.  For an ISDN call.  As you can tell, this doens't work.  :P  So after 6 days of learning more about cisco than I really wanted to, I get the link up.

Moral of the story?

Never trust a manufacturer. :)  That, and don't listen to your boss, when he keeps saying my Cisco Config must be bad, or the router is DOA.  Trust your instincts.

Guennadi Liakhovetski wrote:

> -----Original Message-----An interesting addition:
> I've just got a reply from WD - they say my disk only supports PIO4 and not DMA...
> > I'm taking the case off the machine right now, i can guarantee you its not UDMA compatible, simply because this thing was made in early1997. :)
> >
> > Here we go:
> >
> > MDL WDAC21600-00H
> > P/N 99-004199-000
> > CCC F3 20 FEB 97
> > DCM: BHBBKLP
> >
> > I've got various of these hard drives in service, for the last 4 years.  Many run in windows pc's, and DMA mode in osr2 and newer, works, and is noticeablely faster.
> >
> > Guennadi Liakhovetski wrote:
> >
> > > Glad all this discussion helped at least one of us:-))
> > >
> > > As for me, as I already mentioned in my last posting - I don't know why BIOS makes the difference (as in your case) if ide.txt says it shouldn't?! Ok, chipset, perhaps, is fine. But what about the hard drive? You told you had WDC AC21600H. Can you PLEASE check waht CCC is marked on its label? PLEASE! I am trying to get an answer from WD on this, but not yet alas...
> > >
> > > And - COME ON, GUYS! - somebody MUST know the answer - how to spot the guilty one - kernel configuration / BIOS / chipset / disk???
> > >
> > > Guennadi
> > >
> > > > back in, started playing in the bios.  Finally fixed it.  I was getting > the same operation not permitted, that you
> > > > were,until i got that bios setting. But it's making me
> > > > wonder if it's something similar in your bios!
> > > > I know it wasn't the actual UDMA setting in the bios, i'm
> > > > wondering what it was though.  I'll put a keyboard on it,
> > > > and poke around tonight or this weekend.
> >
> >

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
