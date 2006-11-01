Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946730AbWKAJdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946730AbWKAJdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946731AbWKAJdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:33:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946730AbWKAJdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:33:39 -0500
Date: Wed, 1 Nov 2006 10:33:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linus Torvalds <torvalds@osdl.org>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101093320.GA18641@elf.ucw.cz>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <20061101055435.GB4933@mellanox.co.il> <20061101061857.GC4933@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101061857.GC4933@mellanox.co.il>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-11-01 08:18:57, Michael S. Tsirkin wrote:
> Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
> > What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
> > for a couple of days and see how this works out.
> 
> Ugh. Unfortunately in that kernel version, the e1000 driver says
> the eeprom checksum is bad (works fine with 2.6.19-rc3).
> So, I tried some suspends/resumes and things seem to work, but
> I won't be able to test it under real use conditions.

Just comment out the eeprom checksum check...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
