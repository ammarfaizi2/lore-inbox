Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWGYSAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWGYSAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWGYSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:00:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49884 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751401AbWGYSAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:00:23 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
	corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0607241428070.8650@shell2.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
	 <1153013464.4755.35.camel@praia>
	 <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
	 <1153310092.27276.9.camel@praia>
	 <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
	 <1153484805.16225.12.camel@praia>
	 <Pine.LNX.4.58.0607211226430.26854@shell2.speakeasy.net>
	 <1153513837.32625.71.camel@praia>
	 <Pine.LNX.4.58.0607211536190.26854@shell2.speakeasy.net>
	 <1153647324.22089.32.camel@praia>
	 <Pine.LNX.4.58.0607231828430.16282@shell3.speakeasy.net>
	 <1153744484.22089.56.camel@praia>
	 <Pine.LNX.4.58.0607241428070.8650@shell2.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 25 Jul 2006 14:59:33 -0300
Message-Id: <1153850373.10875.18.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-07-24 às 15:06 -0700, Trent Piepho escreveu:
> On Mon, 24 Jul 2006, Mauro Carvalho Chehab wrote:
> > Em Dom, 2006-07-23 s 19:16 -0700, Trent Piepho escreveu:
> > > Second, the fix for class_device_create_file() doesn't roll-back properly
> > > on failure.  I already posted a patch which does this correctly.  Attached
> > > is the patch against the current Hg, go ahead and import it.
> > On your hg, there are 4 patches to be applied:
> >
> > 1) Fix bug where struct video_device was not defined consistently
> > This one seems to conflict with some previous changes I did. Please
> > remove it from your tree (you need to re-clone it - you may use hg-menu
> > to help on this stuff);
> 
> My Hg tree was outdated by your patches.  If you look at the time, I made
> that fix on Jul 20th, then your comprehensive patch on Jul 23rd
> incorporated that part of the fix.
The point is that your commit ask arrived after I've applied my patches.
> 
> > 3) Handle class_device_create_file in V4L2 drivers
> > The patch didn't applied well at current tree.
> 
> I know, that's why I attached a version to my email that would.  I have now
> re-done my tree to take into account the current code.
Applied. I'm submitting the current stuff to both mainstream and -mm
series.

Cheers, 
Mauro.

