Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWD0Uyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWD0Uyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWD0Uyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:54:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:61117 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751648AbWD0Uyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:54:46 -0400
Date: Thu, 27 Apr 2006 13:53:19 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-ID: <20060427205319.GA30610@suse.de>
References: <20060427014141.06b88072.akpm@osdl.org> <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com> <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com> <20060427152802.GC15806@suse.de> <6bffcb0e0604270832o514f97bi45f871e2cfc832c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0604270832o514f97bi45f871e2cfc832c6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 05:32:43PM +0200, Michal Piotrowski wrote:
> Hi Greg,
> 
> On 27/04/06, Greg KH <gregkh@suse.de> wrote:
> [snip]
> >
> > Ah, I guess it is causing you problems :)
> >
> > > Here is config:
> > > http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/mm-config
> >
> > If you set CONFIG_NDEV_FS=n does the oops go away?
> 
> Yes.

Ok, I've spent a bit of time trying to reproduce this and I can't.  So
I'm just going to drop it from the patch set, because as you point out,
it's never going to go to mainline anyway, it was just a fun hack.

Sorry for the noise,

greg k-h
