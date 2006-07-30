Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWG3JTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWG3JTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWG3JTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:19:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31142 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932110AbWG3JTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:19:44 -0400
Date: Sun, 30 Jul 2006 11:18:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060730091848.GC3801@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728134307.GD29217@suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not understand this. Any polling (in kernel or in userspace) will
> > wake the CPU, wasting power.
> 
> The kernel, however, has all the gory details at hand, and can decide
> much better about the polling frequency, than the (hopefully) hardware
> agnostic userspace.
> 
> Imagine your Zaurus: You don't need to poll very often when you are on
> the flat part of the LiIon discharge curve, you probably want more
> detailed info near the end.

OTOH some applications just want more frequent polling than
others. Shem's "first update after N msec" solution looks most
flexible here.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
