Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTCDVtA>; Tue, 4 Mar 2003 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCDVtA>; Tue, 4 Mar 2003 16:49:00 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:65287 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261701AbTCDVs7>; Tue, 4 Mar 2003 16:48:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303042200.h24M09Y2006001@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] Avoid PC(?) specific cascade dma reservation in
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 4 Mar 2003 22:00:09 +0000 (GMT)
Cc: johan.adolfsson@axis.com, marcelo@conectiva.com.br, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1046818415.12231.14.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Mar 04, 2003 10:53:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess the reservation of dma channel 4 for "cascade" is
> > PC or chipset specific and we don't have such a thing in the 
> > CRIS (ETRAX100LX) chip and channel 4 clashes with external dma0.
> > Perhaps a better fix is to #ifdef on something else or remove 
> > the cascade stuff entirely from this file, but I leave that
> > to those who know better.
> > Have no other arch been bitten by this?
> 
> I don't know of any PC cards that can support ISA DMA channel 4

As far as I know, there is no pin defined for request or
acknowledgement of DMA channel 4 on the ISA bus - or am I missing
something?

John.
