Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966420AbWKNWm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966420AbWKNWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966421AbWKNWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:42:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966420AbWKNWmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:42:25 -0500
Date: Tue, 14 Nov 2006 14:41:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Romano Giannetti <romanol@upcomillas.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia: patch to fix pccard_store_cis
Message-Id: <20061114144126.642af4c8.akpm@osdl.org>
In-Reply-To: <20061114215358.GA1542@isilmar.linta.de>
References: <200611140040.02079.daniel.ritz-ml@swissonline.ch>
	<1163496810.2798.1.camel@localhost>
	<1163500168.2798.8.camel@localhost>
	<200611142250.42295.daniel.ritz-ml@swissonline.ch>
	<20061114215358.GA1542@isilmar.linta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 16:53:58 -0500
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Tue, Nov 14, 2006 at 10:50:41PM +0100, Daniel Ritz wrote:
> > On Tuesday 14 November 2006 11.29, Romano Giannetti wrote:
> > > On Tue, 2006-11-14 at 10:33 +0100, Romano Giannetti wrote:
> > > > On Tue, 2006-11-14 at 00:40 +0100, Daniel Ritz wrote:
> > > > > please also try this patch on top:
> > > > > 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=e6248ff596dd15bce0be4d780c60f173389b11c3
> > > > >
> > > > > (after you have "[PATCH] pcmcia: start over after CIS override"
> > > > > 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=f755c48254ce743a3d4c1fd6b136366c018ee5b2
> > > > >  applied)
> > > >
> > > > Applied, with just a bit of offset on 2.6.17.13. Compiling now. I'll be
> > > > back to you as soon as possible.
> > > >
> > > 
> > > Mr. Ritz,
> > > 
> > > 	IT WORKS. Really. The two functions are recognized  and the modem
> > > answers to minicom and kppp. I color myself happy. I will summarize the
> > > patch and send it to the ubuntu mailing list.
> > > 
> > 
> > that's good news then.
> > so i guess we really want Dominik's pcmcia-fixes-2.6 tree in 2.6.19 then. akpm?
> 
> pcmcia-fixes-2.6 is part of pcmcia-2.6 so it already is in -mm.
> 

He means 2.6.19.  I assume that pcmcia-fixes-2.6 is destined for 2.6.19
anyway?

I'd expect 2.6.19 is 1.0 to 1.5 weeks away...
