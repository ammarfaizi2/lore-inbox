Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbTCZT6b>; Wed, 26 Mar 2003 14:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbTCZT6b>; Wed, 26 Mar 2003 14:58:31 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:41990 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261921AbTCZT5i>; Wed, 26 Mar 2003 14:57:38 -0500
Date: Wed, 26 Mar 2003 20:08:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
In-Reply-To: <1048684571.10476.40.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0303262007550.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 2003-03-25 at 21:50, James Simmons wrote:
> 
> > Try using stty. I see most people will continue to use fbset so I guess I 
> > need to patch it up to do the right thing.
> 
> Well, I don't like the fbdev magially picking modes like this,
> those modes may just not be supported by the display. At least,
> fbset allows me to setup the proper timings for 'special'
> displays like iMac fixed hoziontal frequency for example.
> 
> Ultimately, we really need a "monitor" driver on top of the
> fbdev that does DDC/EDID when the low level fbdev can provide
> an i2c bus or EDID information via some different way and
> that can be tweaked to deal with special monitors when we
> know we are using these.

fbmon.c :-) 

The code should work for PPC and I seen a patch for generic ix86 support. 
No DDC stuff yet tho.


