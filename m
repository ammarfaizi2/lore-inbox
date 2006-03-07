Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCGTGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCGTGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCGTGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:06:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43670
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751447AbWCGTGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:06:03 -0500
Date: Tue, 7 Mar 2006 11:05:49 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Peterson <dsp@llnl.gov>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060307190549.GA18944@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061014.22312.dsp@llnl.gov> <20060306102232.613911f6.rdunlap@xenotime.net> <200603070903.19226.dsp@llnl.gov> <1141758219.3048.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141758219.3048.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 08:03:38PM +0100, Arjan van de Ven wrote:
> 
> > I was initially a bit confused because I thought the comment
> > specifically pertained to the piece of code shown above.  I need to
> > take a closer look at the EDAC sysfs code - I'm not as familiar with
> > some of its details as I should be.  Thanks for pointing out the
> > issue.
> 
> afaics it is a list of pci devices. these should just be symlinks to the
> sysfs resource of these pci devices instead, not a flat table file.

Ugh, all this talk is making me wonder what in the world this code is
doing.  Time to go look at it...

And people complain that all interfaces in userspace should be instantly
marked "stable" because we all know exactly what we are doing :)

greg k-h
