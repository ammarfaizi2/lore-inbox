Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSL1SoF>; Sat, 28 Dec 2002 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSL1SoF>; Sat, 28 Dec 2002 13:44:05 -0500
Received: from crack.them.org ([65.125.64.184]:44448 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261724AbSL1SoE>;
	Sat, 28 Dec 2002 13:44:04 -0500
Date: Sat, 28 Dec 2002 13:53:55 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecated function attribute
Message-ID: <20021228185355.GA22304@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021228035319.903502C04B@lists.samba.org> <20021228153009.GA29614@groucho.verza.com> <1041097877.1066.9.camel@icbm> <1041098631.1066.13.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041098631.1066.13.camel@icbm>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 01:03:52PM -0500, Robert Love wrote:
> On Sat, 2002-12-28 at 12:51, Robert Love wrote:
> 
> > +#if __GNUC__ == 3
> > +#define deprecated	__attribute__((deprecated))
> > +#else
> > +#define deprecated
> > +#endif
> 
> Before someone points it out: I grepped the tree and did not see any
> uses of "deprecated" as a token on first glance.  So the above is safe.
> 
> If we want to be preemptive, we can rename the above to "__deprecated__"
> but I think plain "deprecated" is much better looking.

Eek, please call it something else - something that looks visibly like
a syntax rather than a name.  __deprecated or __deprecated__ or
DEPRECATED.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
