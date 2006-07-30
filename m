Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWG3UJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWG3UJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWG3UJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:09:32 -0400
Received: from mx01.qsc.de ([213.148.129.14]:16779 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932474AbWG3UJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:09:31 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: ipw3945 status
Date: Sun, 30 Jul 2006 22:09:09 +0200
User-Agent: KMail/1.9.3
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <200607301937.15414.rene@exactcode.de> <1154282618.13635.41.camel@localhost>
In-Reply-To: <1154282618.13635.41.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607302209.09735.rene@exactcode.de>
X-Spam-Score: -101.4 (---------------------------------------------------)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  HI, On Sunday 30 July 2006 20:03, Kasper Sandberg wrote:
	> > it would be totally ok if the kernel had a country= command line
	switch > > and the driver limitting functionality due that. > or simply
	state this in the help in Kconfig? > > > > People that want to violate
	the local regulations would require to lie to > > the kernel as they
	could install other country windows and drivers as > > well. > besides,
	im not even sure that specifying in Kconfig is necessary, > wouldnt it
	only be illegal in countries, if people actually modified the > source?
	[...] 
	Content analysis details:   (-101.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Sunday 30 July 2006 20:03, Kasper Sandberg wrote:

> > it would be totally ok if the kernel had a country= command line switch
> > and the driver limitting functionality due that.
> or simply state this in the help in Kconfig?
> > 
> > People that want to violate the local regulations would require to lie to
> > the kernel as they could install other country windows and drivers as
> > well.
> besides, im not even sure that specifying in Kconfig is necessary,
> wouldnt it only be illegal in countries, if people actually modified the
> source?

I proposed a kernel command so distributors have a way to run-time
change this.

However now that I think about it a bit more, a simple sysfs attribute
would be way more useful so the gui tool of the the distribution can
switch the country immediatly and do not require a windows-al-like reboot.

Yours,

-- 
  René Rebe - ExactCODE - Berlin (Europe / Germany)
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
