Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVKVXXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVKVXXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVKVXXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:23:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:58326 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030246AbVKVXXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:23:43 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051122230648.GA7482@stiffy.osknowledge.org>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <20051122140719.GA6784@stiffy.osknowledge.org>
	 <1132700011.26560.240.camel@gaston>
	 <20051122230648.GA7482@stiffy.osknowledge.org>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 10:20:43 +1100
Message-Id: <1132701643.26560.250.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes, but at _least_ with nVidia you get this free "nv" driver that they
> > maintain and that gives you basic mode setting & 2D accel... With the
> > newest ATI cards, you don't even get that.
> > 
> > Ben.
> 
> I use xorg's 'nv' driver. That one is _not_ from nVidia, it it?

It is, though maybe not "officially". It's developped by an nVidia
employee. That's also why it's totally obfuscated: there is not a single
register name in there, only a vast list of magic numbers & magic
values. Mark (the author) claims that he prefers that way and nobody
else is supposed to work on the driver but him ... I find those
arguments a bit bogus (people _do_ occasionally hack on this driver,
and/or use it for the kernel nvidiafb etc...) but heh.. he's the author
so he does what he wants.

Ben.


