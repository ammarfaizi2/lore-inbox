Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUC1CrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 21:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUC1CrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 21:47:18 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:40870 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261987AbUC1CrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 21:47:16 -0500
Date: Sat, 27 Mar 2004 18:47:12 -0800
To: David Brownell <david-b@pacbell.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040328024712.GA30855@reid.corvallis.or.us>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Robert Schwebel <robert@schwebel.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040325221145.GJ10711@pengutronix.de> <40636295.7000008@pacbell.net> <1080297466.29835.144.camel@hades.cambridge.redhat.com> <40644FCA.8000206@pacbell.net> <20040326232328.GA29771@reid.corvallis.or.us> <4065B39A.2040003@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4065B39A.2040003@pacbell.net>
User-Agent: Mutt/1.4i
From: don_reid@comcast.net (don)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 09:02:18AM -0800, David Brownell wrote:
> >>There's a file system protocol used by many digital still cameras,
> >>which isn't actually camera-specific.  Not MSFT-specific either.
> >>...
> >
> >A host driver "USB PTP Storage" would be really nice too.  First
> >as a generic camera interface, second to access a gadget with the
> >PTP interface.
> >
> >(Please embarrass me by saying there already is one, I'll be so happy
> >I won't care :-) ).
> 
> There isn't one.  There are two.  No need to be embarrassed ... ;)
> 
> They're both user-mode drivers.  "gPhoto2", and "jPhoto".  The
> author of jPhoto (moi) hasn't had time to update that code in
> ages.

These are applications, not file system interfaces like USB Mass Storage.
I want to mount the camera or gadget file system and access it from any
program, not run a separate app to fetch files like Mass Stor. mounts
a memory device.

Why create a dedicated app like a camera interface instead of using your
favorite image browser on some files?

-- 
Don Reid
