Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSGaXV1>; Wed, 31 Jul 2002 19:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSGaXV1>; Wed, 31 Jul 2002 19:21:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46845 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318541AbSGaXV0>; Wed, 31 Jul 2002 19:21:26 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@suse.de>
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801010217.K10436@suse.de>
References: <1028062608.964.6.camel@andyp>
	<1028067951.8510.44.camel@irongate.swansea.linux.org.uk>
	<1028063953.964.13.camel@andyp>
	<1028069255.8510.46.camel@irongate.swansea.linux.org.uk>
	<1028152202.964.84.camel@andyp>
	<1028160492.13008.7.camel@irongate.swansea.linux.org.uk> 
	<20020801010217.K10436@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:41:30 +0100
Message-Id: <1028162490.13047.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 00:02, Dave Jones wrote:
> Are there any OSS drivers for any particular cards for which we don't have
> an equivalent ALSA driver ?  If we're ultimately going to be dropping
> any of the OSS drivers, I'd rather know about it so I don't waste time
> pushing the ~200kb of patches in that area I'm currently carrying
> towards Linus.  (Given that most of them don't compile right now due to
> the collateral damage from the cli() etc changes , I'd *love* to take
> the lazy^Weasy option and just drop them)

ALSA should have complete coverage of everything but some weird corner
cases like the bose speaker setup. For those its going to be far better
to fix ALSA (and plugging a new isa card into alsa is really easy) than
lug the entire OSS mess around for it.

