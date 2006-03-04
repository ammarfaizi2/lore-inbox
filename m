Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWCDNSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWCDNSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 08:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCDNSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 08:18:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52240 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751864AbWCDNSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 08:18:21 -0500
Date: Sat, 4 Mar 2006 14:18:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jens Axboe <axboe@suse.de>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       lkml@rtr.ca, linux-ide@vger.kernel.org
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060304131818.GV9295@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de> <4402A219.8010501@pobox.com> <20060227070830.GQ3674@stusta.de> <20060228094053.GT24981@suse.de> <20060228161725.8c731743.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228161725.8c731743.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:17:25PM -0800, Randy.Dunlap wrote:
> On Tue, 28 Feb 2006 10:40:53 +0100 Jens Axboe wrote:
> 
> > On Mon, Feb 27 2006, Adrian Bunk wrote:
> > > On Mon, Feb 27, 2006 at 01:54:17AM -0500, Jeff Garzik wrote:
> > > > Adrian Bunk wrote:
> > > > >Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> > > > >References : http://lkml.org/lkml/2006/2/20/159
> > > > >Submitter  : Mark Lord <lkml@rtr.ca>
> > > > >Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> > > > >Status     : one of Randy's patches seems to fix it
> > > > 
> > > > 
> > > > This is not a regression, libata suspend/resume has always been crappy. 
> > > >  It's under active development (by Randy, among others) to fix this.
> > > 
> > > It might have always been crappy, but it is a regression since
> > > according to the submitter it is working with 2.6.15.
> > 
> > It might have worked under lucky circumstances with an idle disk and a
> > goat sacrifice, so I agree with Jeff that this is definitely not a
> > regression. To my knowledge, Mark always used my libata suspend patch on
> > earlier kernels so it's not even an apples-apples comparison.
> > 
> > So please scratch that entry.
> 
> I'll third that request/comment.

OK, done.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

