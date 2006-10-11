Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWJKXHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWJKXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWJKXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:07:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:28878 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161266AbWJKXHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:07:04 -0400
Date: Wed, 11 Oct 2006 16:04:44 -0700
From: Greg KH <greg@kroah.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Jonathan Corbet <corbet@lwn.net>, torvalds@osdl.org,
       Sascha Hauer <s.hauer@pengutronix.de>, Greg KH <gregkh@suse.de>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 48/67] Fix VIDIOC_ENUMSTD bug
Message-ID: <20061011230444.GC26135@kroah.com>
References: <10090.1160603175@lwn.net> <452D6703.7070900@linuxtv.org> <1160604649.20624.4.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160604649.20624.4.camel@praia>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 07:10:49PM -0300, Mauro Carvalho Chehab wrote:
> Em Qua, 2006-10-11 ?s 17:49 -0400, Michael Krufky escreveu:
> > Jonathan Corbet wrote:
> > >> So any application which passes in index=0 gets EINVAL right off the bat
> > >> - and, in fact, this is what happens to mplayer.  So I think the
> > >> following patch is called for, and maybe even appropriate for a 2.6.18.x
> > >> stable release.
> > > 
> > > The fix is worth having, though I guess I'm no longer 100% sure it's
> > > necessary for -stable, since I don't think anything in-tree other than
> > > vivi uses this interface in 2.6.18.
> True. No real reason to fix into stable. On the other hand, it won't
> hurt -stable to have this fix.
> 
> > > If you are going to include it,
> > > though, it makes sense to put in Sascha's fix too - both are needed to
> > > make the new v4l2 ioctl() interface operate as advertised.
> 
> > This is fine with me...  I have added cc to Mauro, he might want to add
> > his sign-off as well.
> By applying patch 48 into -stable, for sure Sascha fix is required.
> 
> > 
> > Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Thanks, now added.

greg k-h
