Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWHQJND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWHQJND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWHQJNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:13:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15851 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932375AbWHQJNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:13:00 -0400
Date: Thu, 17 Aug 2006 11:12:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Message-ID: <20060817091238.GA17899@elf.ucw.cz>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl> <20060817044011.GB14127@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817044011.GB14127@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> > by people who know exactly what they are doing, from Kconfig.
> 
> No, don't remove this, that's not acceptable at all.  This is useful for
> others (and one specifically who will be pissed to see this removed...)

Yep, while it breaks suspend for every pool soul that enables it by
mistake. (And in hard-to-debug way, too).

This option has EXACTLY ONE USER... or more precisely used to have one
user when he was debugging his mac mini...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
