Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUIGRNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUIGRNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIGRLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:11:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:36741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268234AbUIGQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:53:25 -0400
Date: Tue, 7 Sep 2004 09:52:48 -0700
From: Greg KH <greg@kroah.com>
To: Michal Ludvig <michal@logix.cz>
Cc: James Morris <jmorris@redhat.com>,
       Andreas Happe <andreashappe@flatline.ath.cx>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040907165248.GC8530@kroah.com>
References: <Xine.LNX.4.44.0409071236050.26033-100000@thoron.boston.redhat.com> <Pine.LNX.4.53.0409071845101.19015@maxipes.logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409071845101.19015@maxipes.logix.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:47:06PM +0200, Michal Ludvig wrote:
> On Tue, 7 Sep 2004, James Morris wrote:
> 
> > On Sun, 5 Sep 2004, Greg KH wrote:
> >
> > > Other than that, I like this move, /proc/crypto isn't the best thing to
> > > have in a proc filesystem :)
> >
> > The only issue is what to do about potentially expanding this into an API
> > (e.g. open() an algorithm and write to it).  Does this sort of thing
> > belong in sysfs?
> 
> I already proposed to have a 'cryptoapifs' mounted e.g. under
> /dev/cryptoapi with the "active" entrypoints while /sys would only hold
> the "status" of the cryptoapi. Would this be a better approach?

That sounds acceptable.

thanks,

greg k-h
