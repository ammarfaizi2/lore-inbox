Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRCAQW1>; Thu, 1 Mar 2001 11:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRCAQWR>; Thu, 1 Mar 2001 11:22:17 -0500
Received: from feral.com ([192.67.166.1]:61463 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S129701AbRCAQWA>;
	Thu, 1 Mar 2001 11:22:00 -0500
Date: Thu, 1 Mar 2001 08:21:04 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: kernel@kvack.org, Ofer Fryman <ofer@shunra.co.il>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14
In-Reply-To: <Pine.LNX.3.95.1010301105321.12870A-101000@chaos.analogic.com>
Message-ID: <Pine.BSF.4.21.0103010812200.11811-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Richard B. Johnson wrote:

> On Thu, 1 Mar 2001 kernel@kvack.org wrote:
> 
> > On Thu, 1 Mar 2001, Ofer Fryman wrote:
> > 
> > > I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
> > > successfully. 
> > > With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless interrupts
> > > and the computer freezes, without this bit set it works but I cannot receive
> > > or send anything.
> > 
> > Intel refuses to provide complete documentation for any of their ethernet
> > cards.  I recommend purchasing alternative products from vendors like 3com
> > and National Semiconduct who are cooperative in providing data needed by
> > the development community.
> > 
> 
> Well Intel has been a continual contributor to Linux and BSD. Somebody
> is not getting to the right person. There are lazy people at all
> companies. 

Sorry, I don't believe that that this is correct in this case. I spoke on the
telephone with the "Manager for Open Source Systems", and the concept of
releasing documents to that a driver could be written whose source would be
available was a concept too far. He kept on asking about NDAs- I kept on
saying, yes, I'll sign an NDA (presumably so knowledge of advanced features,
such as VLAN taggging, e.g., would not be released if they did not want it to
be)- but the basic driver source would have to be OPEN! (this was for *BSD,
but that's the same as linux in this case- we *all* want the damned source
open). No meeting of minds. I have been trying this on and off for two years
so that I can properly support the Wiseman && Livengood chipsets in *BSD. No
luck, ergo, reverse engineering of what little they release with the Linux
driver is the order of the day still. The Linux driver, btw, is pretty clearly
a port of an NT driver- which is quite amusing.

FWIW.....I just think that the overall company policy within Intel, much like
that of NetApp and others, is, "Open Source? Well, maybe, err,umm.. "...  It's
just not that important to them (as a company, they think). That said- if you
can get access to said documentation (which I understand comes in a certain
notebook that indicates releasing outside of Intel is a firing offense)- more
power to you!

-matt




