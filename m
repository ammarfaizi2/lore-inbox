Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVAXXT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVAXXT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVAXXTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:19:39 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:4167 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261726AbVAXXBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:01:34 -0500
Subject: Re: DVD burning still have problems
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106598811.6154.93.camel@localhost.localdomain>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
	 <1106598811.6154.93.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 00:01:31 +0100
Message-Id: <1106607691.13336.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 21:44 +0000, Alan Cox wrote:
> On Llu, 2005-01-24 at 20:45, Jens Axboe wrote:
> > > I've got several reports like this that only happen with ACPI, and one
> > > user whose burns report fine but are corrupted if ACPI is allowed to do
> > > power manglement.
> > 
> > Really weird, I cannot begin to explain that. Perhaps the two reporters
> > in this thread can try it as well?
> 
> I can sort of guess - the CPU frequency changes (either from ACPI or
> perhaps also from cpuspeed if in use ?) involve the CPU disconnecting
> from the bus and reconnecting. There is much magic involved in this and
> there are certainly chipset and CPU errata in this area.
would this mean that i should not use cpu frequency scaling?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

