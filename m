Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSFNIXd>; Fri, 14 Jun 2002 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317455AbSFNIXd>; Fri, 14 Jun 2002 04:23:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12550
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313314AbSFNIXc>; Fri, 14 Jun 2002 04:23:32 -0400
Date: Fri, 14 Jun 2002 01:20:34 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <014201c21377$4bbcde20$baefb0d4@nick>
Message-ID: <Pine.LNX.4.10.10206140112490.21513-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick,

http://www.tecchannel.de/hardware/817/index.html

Read about the JUNK hardware base you are working with.
This is one of the reasons people avoid VIA.

OIC, it worked perfectly in wonder kernel but not in the latest.
Did you check to see if there were other changes in the kernel which could
effect the behavior and operations?
A real simple test is to undo the changes to the Promise code and does
the problem still exist?  If it does then it is not the driver it self.

However the other changes in conjuntion could cause problems, that is a
fair point to be made.

So how about including which kernel was the last working version.

For kicks I would back port the driver to prove it is not the driver, or
allow you to prove it is.

Cheers,

On Fri, 14 Jun 2002, Nick Evgeniev wrote:

> Hi,
> 
> > > And I have no kernel errors. Hence I conclude that it's a DRIVER bug.
> >
> > If you had connected them correct the first time like they are now, you
> > would not have had a complaint.  Next, maybe spend more money to get
> > quality hardware, since VIA hardware has a history of being poorly
> > intergrated.
> 
> What are you talking about?! My system was working perfectly for more than 1
> year...
> And then after changing kernel, my cabels magically becomes "wrong
> plugged"?!
> WONDERFULL explanation :-/.
> 
> >
> > Now think for two seconds or longer if needed.
> >
> > It now works and the driver has not changed.
> 
> Yeah... Best driver is not used... wait a second... even not compiled
> driver. Am I right?
> Well anyway, I plan to change hardware shortly to avoid participation in
> never-ending
> promise driver testing cycle.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

