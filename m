Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUISQv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUISQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUISQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:51:58 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:64731 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269285AbUISQvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:51:10 -0400
Message-ID: <35fb2e5904091909515df39acb@mail.gmail.com>
Date: Sun, 19 Sep 2004 17:51:09 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Greg KH <greg@kroah.com>
Subject: Re: udev is too slow creating devices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040915180056.GA23257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040914213506.GA22637@kroah.com>
	 <20040914215122.GA22782@kroah.com>
	 <20040914224731.GF3365@dualathlon.random>
	 <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org>
	 <1095258966.18800.34.camel@icampbell-debian>
	 <20040915152019.GD24818@thundrix.ch> <4148637F.9060706@debian.org>
	 <20040915185116.24fca912.Ballarin.Marc@gmx.de>
	 <20040915180056.GA23257@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 11:00:57 -0700, Greg KH <greg@kroah.com> wrote:

> On Wed, Sep 15, 2004 at 06:51:16PM +0200, Marc Ballarin wrote:

> > This sound complicated and requires changes in many places. Maybe there is
> > an easier solution.

> There is, just run your stuff off of /etc/dev.d/ and stop relying on a
> device node to be present after modprobe returns.

Indeed.

I don't see what is so far for distributions to overcome here - if you
want to avoid having two sets of alternative init scripts, why not
have a generic set of /etc/dev.d entries that are either called by
udev or if udev is not available run them in some predetermined order
on a static device tree. What's the hassle here? I can't see anything
world shattering.

Cheers,

Jon.
