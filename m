Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289889AbSA2VF4>; Tue, 29 Jan 2002 16:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSA2VFr>; Tue, 29 Jan 2002 16:05:47 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:37331 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289829AbSA2VFj>;
	Tue, 29 Jan 2002 16:05:39 -0500
Date: Tue, 29 Jan 2002 16:05:39 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Hassani <hassani@its.caltech.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <E16VJ0e-0001me-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0201291604340.10200-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Alan Cox wrote:

> > Hmm.  What do you recommend?  I remember seeing a spec sheet and register
> > 0x95 was the memory write queue timer.. but I could have dreamed it..
> > Anyone know what register 0x95 does?
>
> It may well the case. All I know is that for some people at least leaving
> 0x95 as the bios set it up works and touching it does not - while for
> the 0x55 case on older chips it all seems to be positive. VIA's own stuff
> doesn't touch 0x95 - maybe there is a reason
>

Really?  VIA's own stuff doesn't touch 0x95?  Hmm.  Well is there ever a
case where touching 0x95 solved ANYTHING?

What do you think?  Should I change the patch to not touch 0x95?



