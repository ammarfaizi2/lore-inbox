Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbTGHXqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267954AbTGHXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:46:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267935AbTGHXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:46:17 -0400
Date: Tue, 8 Jul 2003 16:59:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Russell King <rmk@arm.linux.org.uk>
cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@infradead.org>,
       <vojtech@suse.cz>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
In-Reply-To: <20030709005143.G13083@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0307081656590.993-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jul 2003, Russell King wrote:

> On Wed, Jul 09, 2003 at 01:32:48AM +0200, Pavel Machek wrote:
> > So perhaps we need to add machine_suspend_ram() and
> > machine_suspend_disk() to reboot.h? We *do* want to have some generic
> > interface...
> 
> Sounds good.

There is a similar thing in development at 

	bk://ldm.bkbits.net/linux-2.5-power/

Things are still a bit rough, and there isn't much documentation, as I'm 
busy trying to get it all work correctly before OLS. 

FWIW, I will be talking about this at OLS (and not the posted topic). A 
paper describing the work is here: 

http://kernel.org/pub/linux/kernel/people/mochel/doc/papers/power-ols2003.tar.gz

I should have more to say in the next week or two..


	-pat

