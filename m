Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWB1Joe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWB1Joe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWB1Joe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:44:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4392 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750819AbWB1Jod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:44:33 -0500
Date: Tue, 28 Feb 2006 10:40:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060228094053.GT24981@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de> <4402A219.8010501@pobox.com> <20060227070830.GQ3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227070830.GQ3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27 2006, Adrian Bunk wrote:
> On Mon, Feb 27, 2006 at 01:54:17AM -0500, Jeff Garzik wrote:
> > Adrian Bunk wrote:
> > >Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> > >References : http://lkml.org/lkml/2006/2/20/159
> > >Submitter  : Mark Lord <lkml@rtr.ca>
> > >Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> > >Status     : one of Randy's patches seems to fix it
> > 
> > 
> > This is not a regression, libata suspend/resume has always been crappy. 
> >  It's under active development (by Randy, among others) to fix this.
> 
> It might have always been crappy, but it is a regression since
> according to the submitter it is working with 2.6.15.

It might have worked under lucky circumstances with an idle disk and a
goat sacrifice, so I agree with Jeff that this is definitely not a
regression. To my knowledge, Mark always used my libata suspend patch on
earlier kernels so it's not even an apples-apples comparison.

So please scratch that entry.

-- 
Jens Axboe

