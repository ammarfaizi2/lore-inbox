Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750790AbWFEIpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWFEIpT (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFEIpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:45:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750783AbWFEIpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:45:17 -0400
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linville@tuxdriver.com, Denis Vlasenko <vda@ilport.com.ua>,
        acx100-devel@lists.sourceforge.net, acx100-users@lists.sourceforge.net
In-Reply-To: <20060605083321.GA15690@rhlx01.fht-esslingen.de>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605010636.GB17361@havoc.gtf.org>
	 <20060604181515.8faa8fcf.akpm@osdl.org>
	 <20060605083321.GA15690@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 10:45:09 +0200
Message-Id: <1149497109.3111.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 10:33 +0200, Andreas Mohr wrote:
> Hi,
> 
> On Sun, Jun 04, 2006 at 06:15:15PM -0700, Andrew Morton wrote:
> > On Sun, 4 Jun 2006 21:06:36 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> > > >   It is about time we did something with this large and presumably useful
> > > >   wireless driver.
> > > 
> > > I've never had technical objections to merging this, just AFAIK it had a
> > > highly questionable origin, namely being reverse-engineered in a
> > > non-clean-room environment that might leave Linux legally vulnerable.
> > 
> > I never knew that.
> > 
> > <reads changelog>
> > <reads website>
> > <reads wiki>
> > 
> > I still don't know that.  Denis, do you know the details?
> 
> The acx100 project was started by about 5 people examining the various
> acx100 binary Linux driver "releases" for distro kernels around 2.4.18 etc.
> Since this might fail to comply with usual "clean-room" practices
> (e.g. one party examining a driver and then a separate party implementing
> a new driver with the data gained from examining the original driver),
> it may fail to be seen as acceptable for Linux inclusion.

I disagree there (not speaking for any company just for myself here):
the "clean room" thing is ONLY a USA thing, and is not even required in
the USA. It is a "we want to be extra safe in the USA" thing only. Eg if
you want to be tripple safe and do this in the USA, the clean room is a
good way to be sure.

If you do things in europe or elsewhere, and/or as long as you don't
copy from the original, only use it to learn how it works, you should be
fine as well. It's just that a cleanroom approach is a sure way to prove
you didn't copy. That's all.

If "clean room" now is a requirement for a driver to hit the kernel,
then we need to remove about half the drivers in the kernel I suspect;
that'd just be silly.


I would say that as long as you and the others can certify that you
didn't copy from the original driver, but only used it to learn how it
worked, the kernel should be fine with it.


