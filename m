Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVJVN5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVJVN5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJVN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 09:57:42 -0400
Received: from tim.rpsys.net ([194.106.48.114]:55759 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751254AbVJVN5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 09:57:41 -0400
Subject: Re: spitz (zaurus sl-c3000) support
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051018081501.GE12283@atrey.karlin.mff.cuni.cz>
References: <20051012223036.GA3610@elf.ucw.cz>
	 <1129158864.8340.20.camel@localhost.localdomain>
	 <20051012233917.GA2890@elf.ucw.cz>
	 <1129192418.8238.21.camel@localhost.localdomain>
	 <20051013224419.GF1876@elf.ucw.cz>
	 <1129244547.8238.100.camel@localhost.localdomain>
	 <20051018081501.GE12283@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 14:56:58 +0100
Message-Id: <1129989418.8349.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 10:15 +0200, Pavel Machek wrote:
> > > Oh, okay, one more question. Do you trust your battery charging code
> > > enough to leave spitz overnight in charger? I would hate to be awaken
> > > by angry lithium ;-).
> > 
> > My spitz has been left plugged in all the time with my charging code and
> > has yet to explode. ;-) Its very similar to the c7x0 code which people
> > have happily been using for a while in OpenZaurus c7x0 2.6. Spitz does
> > contain a charging chip which should prevent major damage to the
> > battery. The software just tries to help it along...
> 
> Charge led does not go off, but pavouk (has c7x0) told me that's
> pretty much normal. It made me a bit nervous.

The charge LED should go off but it won't if the device isn't suspended
as when running, the device draws enough current to keep the charger
active.

Help on improving the charging code is of course welcome ;-)

Richard

