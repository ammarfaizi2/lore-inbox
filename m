Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTHSPDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTHSPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:03:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15002
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270641AbTHSO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:59:14 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: headers
Date: Tue, 19 Aug 2003 08:55:06 -0400
User-Agent: KMail/1.5
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl> <bhrvfh$394$1@cesium.transmeta.com>
In-Reply-To: <bhrvfh$394$1@cesium.transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190855.07181.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 August 2003 21:45, H. Peter Anvin wrote:
> Followup to:  <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
> By author:    Andries.Brouwer@cwi.nl
> In newsgroup: linux.dev.kernel
>
> >     From garzik@gtf.org  Mon Aug 18 20:14:47 2003
> >
> >     I support include/abi, or some other directory that segregates
> >     user<->kernel shared headers away from kernel-private headers.
> >
> >     I don't see how that would be auto-generated, though.  Only created
> >     through lots of hard work :)
> >
> > Yes, unfortunately. I started doing some of this a few times,
> > but it is an order of magnitude more work than one thinks at first.
> > Already the number of include files is very large.
> > And the fact that it is not just include/abi but involves the
> > architecture doesn't make life simpler.
> >
> > No doubt we must first discuss a little bit, but not too much,
> > the desired directory structure and naming.
> > Then we must do 5% of the work, and come back to these issues.
> >
> > In case people actually want to do this, I can coordinate.
> >
> > In case people want to try just one file, do signal.h.
>
> Oh yes, this is a whole lot of work.

But is it 2.6 work, or 2.8 work?

Rob


