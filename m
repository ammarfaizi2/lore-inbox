Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGKIeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGKIeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGKIeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:34:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51901 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750745AbWGKIen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:34:43 -0400
Date: Tue, 11 Jul 2006 10:34:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/2] swsusp: clean up browsing of pfns
Message-ID: <20060711083415.GB1787@elf.ucw.cz>
References: <200607102240.45365.rjw@sisk.pl> <200607102251.40083.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607102251.40083.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Clean up some loops over pfns for each zone in snapshot.c: reduce the number
> of additions to perform, rework detection of saveable pages and make the code
> a bit less difficult to understand, hopefully.

Also remove the BUG_ON() so that you can solve Andrew's monster
machine problem. ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
