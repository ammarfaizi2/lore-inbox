Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWFVSXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWFVSXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWFVSXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:23:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751865AbWFVSXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:23:23 -0400
Date: Thu, 22 Jun 2006 20:22:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-ID: <20060622182231.GC4193@elf.ucw.cz>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622092422.256d6692.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hm..
> > Then, there is several ways to manage this sitation.
> > 
> > 1. migrate all even if it's not allowed by users

That's what I'd prefer... as swsusp uses cpu hotplug. All the other
options are bad... admin will probably not realize suspend involves
cpu unplugs..

> > 2. kill mis-configured tasks.
> > 3. stop ...
> > 4. cancel cpu-hot-removal.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
