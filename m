Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSGWUKX>; Tue, 23 Jul 2002 16:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSGWUKW>; Tue, 23 Jul 2002 16:10:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53512
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318202AbSGWUKW>; Tue, 23 Jul 2002 16:10:22 -0400
Date: Tue, 23 Jul 2002 13:08:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <20020723195231.GA14288@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.10.10207231304530.29975-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Jan Harkes wrote:

> On Tue, Jul 23, 2002 at 03:58:58PM +0200, Marcin Dalecki wrote:
> > That's actually not true... At least the setting of the
> > request rq->flags is significantly different here and there.
> > However I think but I'm not sure that the fact aht we have rq->special 
> > != NULL here has the hidded side effect that we indeed accomplish the
> > same semantics.
> > 
> > >And yes it will be useful to move it to block layer.
> > 
> > Done. Just needs testing. I have at least an ZIP parport drive, which
> > allows me to do some basic checks.
> 
> Ehh, you are testing all those IDE changes with a ZIP drive connected to
> the parallel port? Don't you have any real IDE devices?? I'm sure we can
> all chip in and buy you a drive if you need one.

Would be faster to get a real maintainer, but nobody cares about actually
finishing 2.5 or they would find one that could actually make it work
proper.

Andre Hedrick
LAD Storage Consulting Group

-------------------------------------------------------
2.4, has crappy code, an arse-hole maintainer, and a working safe driver.
2.5, erm "Two of Three, ain't BAD"

