Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQLCLbi>; Sun, 3 Dec 2000 06:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbQLCLb3>; Sun, 3 Dec 2000 06:31:29 -0500
Received: from mx6.port.ru ([194.67.23.42]:56849 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S129761AbQLCLbV>;
	Sun, 3 Dec 2000 06:31:21 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: "Mike Dresser" <mdresser@windsormachine.com>, linux-kernel@vger.kernel.org
Subject: Re[2]: DMA !NOT ONLY! for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.44.222.205]
In-Reply-To: <3A27C052.EFBA6D6A@windsormachine.com>
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E142Wt2-00031c-00@f5.mail.ru>
Date: Sun, 03 Dec 2000 14:00:52 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----An interesting addition:
I've just got a reply from WD - they say my disk only supports PIO4 and not DMA...
> I'm taking the case off the machine right now, i can guarantee you its not UDMA compatible, simply because this thing was made in early1997. :)
> 
> Here we go:
> 
> MDL WDAC21600-00H
> P/N 99-004199-000
> CCC F3 20 FEB 97
> DCM: BHBBKLP
> 
> I've got various of these hard drives in service, for the last 4 years.  Many run in windows pc's, and DMA mode in osr2 and newer, works, and is noticeablely faster.
> 
> Guennadi Liakhovetski wrote:
> 
> > Glad all this discussion helped at least one of us:-))
> >
> > As for me, as I already mentioned in my last posting - I don't know why BIOS makes the difference (as in your case) if ide.txt says it shouldn't?! Ok, chipset, perhaps, is fine. But what about the hard drive? You told you had WDC AC21600H. Can you PLEASE check waht CCC is marked on its label? PLEASE! I am trying to get an answer from WD on this, but not yet alas...
> >
> > And - COME ON, GUYS! - somebody MUST know the answer - how to spot the guilty one - kernel configuration / BIOS / chipset / disk???
> >
> > Guennadi
> >
> > > back in, started playing in the bios.  Finally fixed it.  I was getting > the same operation not permitted, that you
> > > were,until i got that bios setting. But it's making me
> > > wonder if it's something similar in your bios!
> > > I know it wasn't the actual UDMA setting in the bios, i'm
> > > wondering what it was though.  I'll put a keyboard on it,
> > > and poke around tonight or this weekend.
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
