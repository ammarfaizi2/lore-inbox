Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSA2VUF>; Tue, 29 Jan 2002 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSA2VT4>; Tue, 29 Jan 2002 16:19:56 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:25532 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S280588AbSA2VTh>; Tue, 29 Jan 2002 16:19:37 -0500
Subject: Re: Athlon Optimization Problem
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steven Hassani <hassani@its.caltech.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0201291604340.10200-100000@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.30.0201291604340.10200-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 16:19:16 -0500
Message-Id: <1012339159.12557.18.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 16:05, Calin A. Culianu wrote:
> > It may well the case. All I know is that for some people at least leaving
> > 0x95 as the bios set it up works and touching it does not - while for
> > the 0x55 case on older chips it all seems to be positive. VIA's own stuff
> > doesn't touch 0x95 - maybe there is a reason
> >
> 
> Really?  VIA's own stuff doesn't touch 0x95?  Hmm.  Well is there ever a
> case where touching 0x95 solved ANYTHING?
> 
> What do you think?  Should I change the patch to not touch 0x95?

I know it is fairly common for Award BIOS to touch 0x95.  For example
Soyo Dragon Plus and Epox 8kha+.  Either that or the chipset on these
boards defaults to something that doesn't require the fixup.

Trever Adams


