Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUH0NwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUH0NwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUH0NwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:52:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265044AbUH0NwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:52:21 -0400
Date: Fri, 27 Aug 2004 09:00:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-pre2
Message-ID: <20040827120020.GC32707@logos.cnet>
References: <412E012F.4050503@ttnet.net.tr> <20040826191501.GA12772@fs.tum.de> <412E3EEB.5010603@ttnet.net.tr> <20040826222622.GD564@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826222622.GD564@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 12:26:22AM +0200, Willy Tarreau wrote:
> On Thu, Aug 26, 2004 at 10:50:03PM +0300, O.Sezer wrote:
> > >They are not a real problem with gcc 3.4, and whether gcc 3.5 will ever 
> > >be supported as compiler for kernel 2.4 is a question whose answer lies 
> > >far in the future.
> > 
> > That is a valid point but it'd be sad if gcc3.5 wouldn't be supported.
> 
> Tell that to gcc developpers who constantly break compatibility between
> versions. I even have userland programs which do not compile anymore with
> gcc-3.3 and which I don't even know how to 'fix' (workaround ?).

I dont care much about having gcc 3.5 work on v2.4 right now. Right now I think 
we wont ever care about supporting it.

gcc 3.4 is more a of a concern because there is demand for it - Mikael has been
maintaining the patches out-of-the-tree for sometime now and I received
quite some reports about them (ie there is pressure for that).

But, due to the v2.4 state of life (bugfix mode only), I've been very annoyed 
by these patches already. Uninliningfunctions is the most annoying thing 
to me.

It doenst make sense for it (v2.4) to work on new-shiny-gcc next generation, v2.6/2.7 
are there to support those.
