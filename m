Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVBRUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVBRUja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVBRUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:39:30 -0500
Received: from mail1.kontent.de ([81.88.34.36]:37508 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261482AbVBRUj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:39:27 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 21:39:24 +0100
User-Agent: KMail/1.7.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
References: <20050213004729.GA3256@stusta.de> <200502181805.13129.oliver@neukum.org> <20050218201429.GA1403@elf.ucw.cz>
In-Reply-To: <20050218201429.GA1403@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502182139.24520.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Februar 2005 21:14 schrieb Pavel Machek:
> Hi!
> 
> > > > Yes, there are. They can probably stay... Or we can get "battery low"
> > > > key.
> > >  
> > > We even have an event class for that, EV_PWR in the input subsystem.
> > 
> > Over that route we'd arrive at a situation where power management
> > without the input layer is impossible. Think about embedded stuff I wonder
> > whether this is viable.
> 
> I'd say it is: you need some support to get it into userspace. And I'd
> certianly prefer input infrastructure over ACPI infrastructure...

If it could replace ACPI (or some abstraction thereof), maybe.
But power management needs communication in both ways
(like setting warn levels and transfers complex things, like
queries for battery power which cannot easily be abstracted as events)

	Regards
		Oliver
