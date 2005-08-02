Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVHBLSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVHBLSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVHBLSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:18:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25047 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261497AbVHBLSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:18:05 -0400
Date: Tue, 2 Aug 2005 13:17:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
Message-ID: <20050802111754.GC1390@elf.ucw.cz>
References: <1122904460.6491.41.camel@localhost.localdomain> <1122905228.6881.9.camel@localhost> <1122907136.31350.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122907136.31350.45.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Mon, 2005-08-01 at 15:54 +0200, Antonio-M. Corbi Bellot wrote:
> > 
> > > Has anyone observed this behaviour (O.S. halt ok but _no_ power-off at
> > > the end) with these new '-rc' kernels?
> > 
> > Yes. I haven't looked for the cause yet though.
> 
> I found that if you comment the 
> 	device_suspend(PMSG_SUSPEND);
> line in kernel/sys.c, in the kernel_power_off() function, then it works
> again, but I haven't had the time to look further.
> 
> I've put LKML in CC: in case this rings someone's bell.

Can you try without USB? With USB but without experimental
CONFIG_USB_SUSPEND?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
