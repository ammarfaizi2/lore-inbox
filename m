Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWBGAXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWBGAXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWBGAXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:23:21 -0500
Received: from xenotime.net ([66.160.160.81]:51608 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964888AbWBGAXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:23:21 -0500
Date: Mon, 6 Feb 2006 16:23:19 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mark Lord <lkml@rtr.ca>
cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <nigel@suspend2.net>,
       Rafael Wysocki <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2]
 Modules support.)
In-Reply-To: <43E7E7B2.90909@rtr.ca>
Message-ID: <Pine.LNX.4.58.0602061622530.10161@shark.he.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
 <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz>
 <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz>
 <43E761EB.3030203@rtr.ca> <20060206145224.GC1675@elf.ucw.cz> <43E7E7B2.90909@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Mark Lord wrote:

> Pavel Machek wrote:
> > On Po 06-02-06 09:49:15, Mark Lord wrote:
> >>> I'm not sure if we want to save full image of memory. Saving most-used
> >>> caches only seems to work fairly well.
> >> No, it sucks.  My machines take forever to become usable on resume
> >> with the current method.  But dumping full image of memory will need
> >> compression to keep that from being sluggish as well.
> >
> > Are you sure? This changed recently, be sure to set
> > /sys/power/image_size.
>
> No such pathname in 2.6.15 (the latest released kernel).

_recently_.  It's in 2.6.16-rc1 and later.

-- 
~Randy
