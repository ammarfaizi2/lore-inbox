Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946832AbWKAMEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946832AbWKAMEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423975AbWKAMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:04:05 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:60562 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1423960AbWKAMEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:04:02 -0500
Date: Wed, 1 Nov 2006 14:02:39 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101120239.GA7679@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061101093320.GA18641@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101093320.GA18641@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek <pavel@ucw.cz>:
> > > What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
> > > for a couple of days and see how this works out.
> > 
> > Ugh. Unfortunately in that kernel version, the e1000 driver says
> > the eeprom checksum is bad (works fine with 2.6.19-rc3).
> > So, I tried some suspends/resumes and things seem to work, but
> > I won't be able to test it under real use conditions.
> 
> Just comment out the eeprom checksum check...
> 

Right, that worked, thanks.
I'm running on eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2 now, seems to be fine
so far.

-- 
MST
