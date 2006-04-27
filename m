Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWD0P3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWD0P3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWD0P3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:29:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:32667 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030186AbWD0P3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:29:30 -0400
Date: Thu, 27 Apr 2006 08:28:02 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-ID: <20060427152802.GC15806@suse.de>
References: <20060427014141.06b88072.akpm@osdl.org> <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com> <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 03:07:54PM +0200, Michal Piotrowski wrote:
> On 27/04/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Hi Andrew,
> >
> > On 27/04/06, Andrew Morton <akpm@osdl.org> wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> > >
> > [snip]
> > > +gregkh-devfs-ndevfs.patch
> >
> > "You don't really want to run this.  But if you did, here's a simple hack
> > showing how easy it is to do it.
> >
> > Note, this patch will NOT be merged into mainline, so don't get your
> > panties into a bind..."
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/ndevfs.patch
> >
> > Please drop this patch.
> 
> Here is oops:
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/oops1.jpg

Ah, I guess it is causing you problems :)

> Here is config:
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/mm-config

If you set CONFIG_NDEV_FS=n does the oops go away?

thanks,

greg k-h
