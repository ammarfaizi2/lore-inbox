Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRGEJOP>; Thu, 5 Jul 2001 05:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRGEJOF>; Thu, 5 Jul 2001 05:14:05 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:31207 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S261651AbRGEJN6>; Thu, 5 Jul 2001 05:13:58 -0400
Message-ID: <3B44304E.1973C43D@idcomm.com>
Date: Thu, 05 Jul 2001 03:15:58 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <01Jul4.172916edt.62972@gpu.utcc.utoronto.ca> <994322676.768.0.camel@tux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:
> 
> On 04 Jul 2001 17:29:12 -0400, Chris Siebenmann wrote:
> > You write:
> > | I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> > | my house with more than 128 MB RAM?!? Can someone please point out to me
> > | that he's actually running kernel-2.4.x on a machine with more than 128
> > | MB RAM and that he's NOT having severe stability problems?
> >
> >  Me. Two machines. (Both 2.4.5 high -ac kernels.)
> >
> >  I strongly suggest getting memtest86 and running it on all of your
> > problematic machines.
> 
> I ran memtest tonight on all machines....
> It gave 0 errors on all of them.....
> 
> So.... this leads to the conclusion that the memory is okay, and that
> something else must be the problem.... Could it still be a failing power
> supply or something? It seems both computers have a 230 W power supply.
> Might be a problem, I guess, I can buy a 400 W thingy if that makes
> sense.
> 
> Other solutions I heard:
> - antistatic wrist strap: already have one :-)
> - BIOS fiddling... What exactly should I look for? They are, as far as I
> can see, identical memory sticks, probably both from different
> suppliers, but besides that quite the same....

Look for wait states. Add a wait state, which slows down access to the
ram (if it doesn't help, put it back where it was).

> - are there different brands of memory of different quality and might
> that be a possible cause of the problems? And if so - what are good
> memory brands and what are the bad ones?
> - I mixed different types of SDRAM... Could be it.... My mainboard
> manual is not really clear about this.... And I have no clue what brand
> of memory I bought... they are all 133 MHz SDRAM sticks, some 64 MB,
> some 128 MB.... MB manual says it can handle all 64/128 MB sticks...

Mixing different types is a bad thing to leave to chance. Corsair and
Kingston I *think* are good brands.

> - <your solution here :-)>

Try each memory stick by itself; if it only fails when both are in at
once, reverse the slots they are in; if it still fails, get another
stick that is the same brand and type as another, try just those
together.

> 
> Anyway, thanks for any advice until now and thanks for listening again,
> hope to hear more solutions.
> 
> --
> Ronald Bultje
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
