Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268730AbRG3XJ6>; Mon, 30 Jul 2001 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268733AbRG3XJr>; Mon, 30 Jul 2001 19:09:47 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:13136 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S268730AbRG3XJ1>; Mon, 30 Jul 2001 19:09:27 -0400
Date: Mon, 30 Jul 2001 18:09:33 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
cc: Thomas Zehetbauer <thomasz@hostmaster.org>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver still broken
In-Reply-To: <01073016571903.25803@widmers.oce.srci.oce.int>
Message-ID: <Pine.LNX.3.96.1010730180814.27870D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Joshua Schmidlkofer wrote:
> I am afraid of post these days.  However, I must comment that I too am having 
> trouble with the tulip driver, on several SMC nic's that use the DEC  
> chipset.  I tried mii_tool, with no success.
> 
> I have just been copying the tulip driver from 2.4.4 forward...   because I 
> don't have enough time to try and create an intelligent error report.

Thanks for the report!

Currently there are problems with 21041 old chipsets, which include SMC
and several other cards.  You can use 0.9.14 from
http://sf.net/projects/tulip/ until I get around to fixing it.

(off vacation, but now moving to new house w/ no Internet :))

	Jeff




> On Monday 30 July 2001 04:19 pm, Thomas Zehetbauer wrote:
> > My genuine digital network interface card ceased to work with the tulip
> > driver contained in kernel revisions >= 2.4.4 and the development driver
> > from sourceforge.net.
> >
> > It seems that the driver incorrectly configures the card for full duplex
> > mode and I could not figure out how to override this with the new
> > MODULE_PARM macro.
> >
> > I am now using the stable driver 0.9.14 from sourceforge.net which works
> > fine.

