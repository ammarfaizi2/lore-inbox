Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317455AbSFNIh6>; Fri, 14 Jun 2002 04:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317595AbSFNIh5>; Fri, 14 Jun 2002 04:37:57 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:29568 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317455AbSFNIh4>;
	Fri, 14 Jun 2002 04:37:56 -0400
Date: Fri, 14 Jun 2002 10:37:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
Message-ID: <20020614103746.A324@ucw.cz>
In-Reply-To: <014201c21377$4bbcde20$baefb0d4@nick> <Pine.LNX.4.10.10206140112490.21513-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 01:20:34AM -0700, Andre Hedrick wrote:
> 
> Nick,
> 
> http://www.tecchannel.de/hardware/817/index.html
> 
> Read about the JUNK hardware base you are working with.
> This is one of the reasons people avoid VIA.

Hmm, I don't want to interfere in this nicely-growing flamethrowing, but
Andre, you might have noticed, that Nick is saying that it actually
*works* on the VIA controller and doesn't on the Promise one. Plus older
kernels do work on the Promise controller. That's clearly a software
problem.

> OIC, it worked perfectly in wonder kernel but not in the latest.
> Did you check to see if there were other changes in the kernel which could
> effect the behavior and operations?
> A real simple test is to undo the changes to the Promise code and does
> the problem still exist?  If it does then it is not the driver it self.
> 
> However the other changes in conjuntion could cause problems, that is a
> fair point to be made.
> 
> So how about including which kernel was the last working version.
> 
> For kicks I would back port the driver to prove it is not the driver, or
> allow you to prove it is.
> 
> Cheers,
> 
> On Fri, 14 Jun 2002, Nick Evgeniev wrote:
> 
> > Hi,
> > 
> > > > And I have no kernel errors. Hence I conclude that it's a DRIVER bug.
> > >
> > > If you had connected them correct the first time like they are now, you
> > > would not have had a complaint.  Next, maybe spend more money to get
> > > quality hardware, since VIA hardware has a history of being poorly
> > > intergrated.
> > 
> > What are you talking about?! My system was working perfectly for more than 1
> > year...
> > And then after changing kernel, my cabels magically becomes "wrong
> > plugged"?!
> > WONDERFULL explanation :-/.
> > 
> > >
> > > Now think for two seconds or longer if needed.
> > >
> > > It now works and the driver has not changed.
> > 
> > Yeah... Best driver is not used... wait a second... even not compiled
> > driver. Am I right?
> > Well anyway, I plan to change hardware shortly to avoid participation in
> > never-ending
> > promise driver testing cycle.
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
