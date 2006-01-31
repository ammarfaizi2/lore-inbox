Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWAaUvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWAaUvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWAaUve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:51:34 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15253 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751476AbWAaUve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:51:34 -0500
Subject: Re: R: Xorg  crashes 2.6.16-rc1-git4
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mauro Tassinari <mtassinari@cmanet.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAATCL5fQYOzEifgaWohcVWWwEAAAAA@cmanet.it>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAATCL5fQYOzEifgaWohcVWWwEAAAAA@cmanet.it>
Date: Tue, 31 Jan 2006 22:51:29 +0200
Message-Id: <1138740690.22358.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Tue, 2006-01-31 at 21:34 +0100, Mauro Tassinari wrote:
> > > My test system running vanilla 2.6.16-rc1 (slackware-current 
> > > config) freezes dead as soon as Xorg is started. 
> > >  
> > > Only a reset is possible, so no info can be gathered after 
> > the crash. 
> > >  
> > > Kernel 2.6.15 works flawlessy. 
> > >  
> >  
> > same applyes to rc1-git4 
> >   
> > see previous message for details. 
> 
> changed card. 
> nvidia works. 
> will try to work out some more details. 
> meanwhile, here are the config changes:

[snip]

> in both cases, no kernel video module was loaded. 
> Hope this helps a bit, thank you for your attention.

Does disabling CONFIG_DRM_RADEON fix the hard lock? You have compiled
Radeon DRM as module so I think X will try to load it at start-up.

			Pekka

