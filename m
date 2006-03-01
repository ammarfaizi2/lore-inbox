Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWCAAQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWCAAQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWCAAQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:16:08 -0500
Received: from xenotime.net ([66.160.160.81]:3214 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932629AbWCAAQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:16:07 -0500
Date: Tue, 28 Feb 2006 16:17:25 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jens Axboe <axboe@suse.de>
Cc: bunk@stusta.de, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, lkml@rtr.ca,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.16-rc5: known regressions
Message-Id: <20060228161725.8c731743.rdunlap@xenotime.net>
In-Reply-To: <20060228094053.GT24981@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060227061354.GO3674@stusta.de>
	<4402A219.8010501@pobox.com>
	<20060227070830.GQ3674@stusta.de>
	<20060228094053.GT24981@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 10:40:53 +0100 Jens Axboe wrote:

> On Mon, Feb 27 2006, Adrian Bunk wrote:
> > On Mon, Feb 27, 2006 at 01:54:17AM -0500, Jeff Garzik wrote:
> > > Adrian Bunk wrote:
> > > >Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> > > >References : http://lkml.org/lkml/2006/2/20/159
> > > >Submitter  : Mark Lord <lkml@rtr.ca>
> > > >Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> > > >Status     : one of Randy's patches seems to fix it
> > > 
> > > 
> > > This is not a regression, libata suspend/resume has always been crappy. 
> > >  It's under active development (by Randy, among others) to fix this.
> > 
> > It might have always been crappy, but it is a regression since
> > according to the submitter it is working with 2.6.15.
> 
> It might have worked under lucky circumstances with an idle disk and a
> goat sacrifice, so I agree with Jeff that this is definitely not a
> regression. To my knowledge, Mark always used my libata suspend patch on
> earlier kernels so it's not even an apples-apples comparison.
> 
> So please scratch that entry.

I'll third that request/comment.

---
~Randy
