Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933059AbWF3TOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWF3TOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933069AbWF3TOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:14:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933140AbWF3TOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:14:49 -0400
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_V4L1 shouldn't be
	user-visible
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910606291759t140e1ea7yf14cca699988cd50@mail.gmail.com>
References: <20060629192124.GD19712@stusta.de>
	 <1151612317.3728.34.camel@praia> <20060629210829.GG19712@stusta.de>
	 <1151617411.3728.66.camel@praia>
	 <9e4733910606291759t140e1ea7yf14cca699988cd50@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 30 Jun 2006 16:14:34 -0300
Message-Id: <1151694874.2006.7.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2006-06-29 às 20:59 -0400, Jon Smirl escreveu:
> On 6/29/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> > Also, on V4L side, the V4L1 api is stopping V4L development. V4L API 2
> > is already at kernel since the beginning of kernel 2.6 series, and fixes
> > several flaws at the old api (V4L1 API were designed on 2.1 series).
> > Still now, most applications still implement only V4L1, and people do
> > submit newer v4l1 drivers to us.
> >
> > We do really go ahead, making V4L2 API the standard.
> 
> I don't think anyone would complain about dropping V4L1 if the people
> pushing V4L2 were to port the 25 or so drivers that depend on V4L1 to
> the V4L2 API.
We are working on it. The issue will be someone to test all those
drivers for the obsolete hardwares.
> As long as those V4L1 dependent drivers are around
> people are going to want to keep using V4L1. You may want to consider
> building some in-kernel compatibility APIs into V4L2 to make porting
> those drivers easier.
Most of changes are just trivial. Just one will requre more work, since
it is related to newer mmap methods on V4L2.
> 
Cheers, 
Mauro.

