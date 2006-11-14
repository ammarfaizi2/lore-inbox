Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966389AbWKNVwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966389AbWKNVwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966396AbWKNVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:52:24 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:40608 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S966389AbWKNVwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:52:23 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Romano Giannetti <romanol@upcomillas.es>, Andrew Morton <akpm@osdl.org>
Subject: Re: pcmcia: patch to fix pccard_store_cis
Date: Tue, 14 Nov 2006 22:50:41 +0100
User-Agent: KMail/1.7.2
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611140040.02079.daniel.ritz-ml@swissonline.ch> <1163496810.2798.1.camel@localhost> <1163500168.2798.8.camel@localhost>
In-Reply-To: <1163500168.2798.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142250.42295.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-02.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 11.29, Romano Giannetti wrote:
> On Tue, 2006-11-14 at 10:33 +0100, Romano Giannetti wrote:
> > On Tue, 2006-11-14 at 00:40 +0100, Daniel Ritz wrote:
> > > please also try this patch on top:
> > > 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=e6248ff596dd15bce0be4d780c60f173389b11c3
> > >
> > > (after you have "[PATCH] pcmcia: start over after CIS override"
> > > 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=f755c48254ce743a3d4c1fd6b136366c018ee5b2
> > >  applied)
> >
> > Applied, with just a bit of offset on 2.6.17.13. Compiling now. I'll be
> > back to you as soon as possible.
> >
> 
> Mr. Ritz,
> 
> 	IT WORKS. Really. The two functions are recognized  and the modem
> answers to minicom and kppp. I color myself happy. I will summarize the
> patch and send it to the ubuntu mailing list.
> 

that's good news then.
so i guess we really want Dominik's pcmcia-fixes-2.6 tree in 2.6.19 then. akpm?

rgds
-daniel
