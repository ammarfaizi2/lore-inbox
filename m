Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUIKIwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUIKIwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUIKIwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:52:17 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:61335 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S267656AbUIKIwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:52:16 -0400
Date: Sat, 11 Sep 2004 10:52:15 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netwinder or ARM build platform
Message-ID: <20040911085215.GD13173@xi.wantstofly.org>
References: <200409091759.i89HxHI2023135@work.bitmover.com> <1094772143.9144.42.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094772143.9144.42.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:22:23AM +0100, David Woodhouse wrote:

> > BK found another bad hard drive today, on our netwinder.  The disk is dieing
> > badly unfortunately and I don't have installation media for this beast.
> > I suspect I can go find it but does anyone know of a faster build platform
> > for arm?  Russell uses bk on arms (no kidding, that's amazing) and so we
> > continue to support it but that netwinder is just amazingly slow.  If there
> > is a faster platform we want one.
> 
> TBH I'd suggest cross-building and testing in qemu-arm. Assuming
> qemu-arm is actually working now.

Not quite.  It works okay for simple binaries now, but still craps out
on running bigger apps such as gcc.

I'm using the gumstix (www.gumstix.com) myself for little endian ARM
builds, but they only have 64M RAM and no ethernet or IDE.  For big
endian, I use the Linksys NSLU2, which has only 32M RAM but ethernet
and dual USB (which lets you hook up a disk each.)


--L
