Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSA2U4e>; Tue, 29 Jan 2002 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSA2U4Y>; Tue, 29 Jan 2002 15:56:24 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:35027 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289858AbSA2U4O>;
	Tue, 29 Jan 2002 15:56:14 -0500
Date: Tue, 29 Jan 2002 15:56:14 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steven Hassani <hassani@its.caltech.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.LNX.4.40.0201290900490.7168-100000@infcip10.uni-trier.de>
Message-ID: <Pine.LNX.4.30.0201291553360.10200-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Daniel Nofftz wrote:

> On Mon, 28 Jan 2002, Calin A. Culianu wrote:
>
> > Hmm.  What do you recommend?  I remember seeing a spec sheet and register
> > 0x95 was the memory write queue timer.. but I could have dreamed it..
> >
> > Anyone know what register 0x95 does?
>
> hmmm ... when i was working on the athlon disconnect patch i found that
> the pcr files (resorce files) for the wpcredit programm (windows tool for
> changing the configuration of chipset) are a good source of information.
> but this register isn't discribed in this file ... sorry
>
> daniel
> (i placed the pcr file on the web, if you are interested, have a look at:
> http://cip.uni-trier.de/nofftz/linux/kt266_pcr.txt ... the webserver is
> down at the moment, but should be up again in 1-2 hours)

Thank you kindly, Daniel.  It's strange that register 95 is ommitted.  We
definitely can conclude that register 55 is not the one to set on the
kt266 motherboards (whereas on the other via motherboards it *is* the one
to set...  I even have the spec sheet to prove it! :) )

I really wish VIA were more willing to cooperate with us and give us spec
sheets.  It's to their advantage to have us make their buggy motherboards
work well with linux, for crying out loud!  I really don't get what the
big deal is.  I mean it's not like the concept of setting bytes on a pci
device to change functionality is so revolutionary it deserves to be
obfuscated...

-Calin

