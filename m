Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVKVIo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVKVIo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKVIo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:44:59 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:7082 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751059AbVKVIo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:44:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=syZ9wtFFMwbXBBfhK63fb+bAYFYajXyRupxfN4rXmyQ56ujR/IVbMlm5HBEFl0rU4/VfVqvyRQ7l34Y+GXa+SoOE1zG2kES2JscPvUgh3DjuCqqkmai+YN4dBY+72Mp1m0Hot98dgGijZ4VPB2avZGZmBCePfMUpOBldS0ipKhk=
Message-ID: <21d7e9970511220044w23a3033dyf2f8f2e95e7928aa@mail.gmail.com>
Date: Tue, 22 Nov 2005 19:44:57 +1100
From: Dave Airlie <airlied@gmail.com>
To: Rob Landley <rob@landley.net>
Subject: Re: [RFC] Small PCI core patch
Cc: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511220141.05877.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
	 <200511220141.05877.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On the hardware front, there are some signs of hope.  My dell laptop may
> actually have a usable open source driver for its video hardware, totally
> reverse engineered of course:
> http://r300.sourceforge.net/
>
> And someday I hope to actually build X from source, and opengl, and try
> testing this sucker.  It probably won't be this week.  Geeky as I am,
> building X, DRI, and openGL from source isn't something I do casually.  But
> how can I try this out any other way?
>
> The problem isn't the lack of technology.  We've got forcedeth for network
> cards that never had a spec because when people did this work lots of end
> users showed up to try it out.  But if you look at the status log for the
> radeon driver I mentioned above, it only seems to get touched every 2 months
> and the last time was in july.  And this is something that, according to
> their web page, mostly works now for the hardware I've got...

The r300 driver is merged into the mainline projects so r300.sf.net is
no longer the source for it. Mesa CVS now has support for it and as
far as I know you can grab binary snapshots from
http://dri.freedesktop.org/snapshots/ saves a lot of compiling from
source if they work..

Dave.
