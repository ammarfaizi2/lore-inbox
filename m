Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUCZXXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUCZXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:23:41 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:37047 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261427AbUCZXXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:23:33 -0500
Date: Fri, 26 Mar 2004 15:23:28 -0800
To: David Brownell <david-b@pacbell.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326232328.GA29771@reid.corvallis.or.us>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Robert Schwebel <robert@schwebel.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040325221145.GJ10711@pengutronix.de> <40636295.7000008@pacbell.net> <1080297466.29835.144.camel@hades.cambridge.redhat.com> <40644FCA.8000206@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40644FCA.8000206@pacbell.net>
User-Agent: Mutt/1.4i
From: don_reid@comcast.net (don)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 07:44:10AM -0800, David Brownell wrote:
> There's a file system protocol used by many digital still cameras,
> which isn't actually camera-specific.  Not MSFT-specific either.
> 
> Originally called "Picture Transfer Protocol" (PTP) it's actually
> more of a remote hierarchical filesystem protocol ... with an event
> channel (handy for "new picture" or "inserted new flash memory")
> and some built-in search capabilities ("what JPGs do you have").
> The strangest capability was a file type tag, which isn't actually
> that bizarre.
> 
> As with RNDIS, and USB Mass Storage, I understand that support for
> PTP is part of MS-Windows since about Win2K.  So a PTP gadget
> driver would probably be a useful contribution to Linux.

A host driver "USB PTP Storage" would be really nice too.  First
as a generic camera interface, second to access a gadget with the
PTP interface.

(Please embarrass me by saying there already is one, I'll be so happy
I won't care :-) ).

I have a PTP camera and would certainly be happy to test such a driver.
Time to write it is a different matter.

Don Reid
