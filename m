Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLHNe6>; Sun, 8 Dec 2002 08:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLHNe6>; Sun, 8 Dec 2002 08:34:58 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:31671 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261349AbSLHNe5>; Sun, 8 Dec 2002 08:34:57 -0500
Subject: Re: [PATCH][2.5][RFT] ide-pnp.c conversion to new PnP layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Shawn Starr <spstarr@sh0n.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.50.0212080518480.2139-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0212071511550.3130-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0212071936320.2139-100000@montezuma.mastecende.com>
	<200212072245.56906.spstarr@sh0n.net> <200212072250.49687.spstarr@sh0n.net>
	 <Pine.LNX.4.50.0212080518480.2139-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 14:17:26 +0000
Message-Id: <1039357046.6942.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 10:21, Zwane Mwaikambo wrote:
> On Sat, 7 Dec 2002, Shawn Starr wrote:
> 
> > Things have been going on the background (this issue that is). The drive is
> > detected with TCQ disabled (kernel panics when enabled).
> 
> Known issue, unsupported configuration, i hit that in my test runs ;)

The TCQ code is broken on lots of controllers, thats one reason I always
tell people to disable it. Jens probably has more important block things
to worry about first though

