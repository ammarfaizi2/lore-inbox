Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULEXft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULEXft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULEXeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:34:44 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:41601 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261427AbULEXc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:32:57 -0500
Date: Mon, 6 Dec 2004 00:32:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are waiting in my tree
Message-ID: <20041205233230.GC1490@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz> <1102284611.11763.97.camel@gaston> <20041205232440.GA1490@elf.ucw.cz> <1102289413.11761.110.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102289413.11761.110.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We need to add pm_message_t to resume, I agree about that, but yes, it
> > would be quite bad if I added this, too.
> > 
> > All changes I'm doing are "break nothing", because pm_message_t is
> > typedefed to u32 for now. Therefore they can be safely merged in any
> > order etc...
> 
> Hrm... adding it to all resume, if done at once, won't break anything
> since nobody uses it yet.

"Done at once" is going to be a problem. I do not have that kind of
magical sed skills yet ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
