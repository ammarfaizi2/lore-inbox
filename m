Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGaV7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGaV7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWGaV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:59:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40881 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751191AbWGaV7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:59:46 -0400
Date: Mon, 31 Jul 2006 23:59:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: nathans@sgi.com, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: XFS vs. swsusp
Message-ID: <20060731215933.GB3612@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rafael has patches to add bdev freezing to swsusp. I'd like to know if
they are neccessary (and why).

1) Is sync() enough to guarantee that all the data written before sync
actually reach the platters?

(Or is it that data only reach the journal? OTOH that would be okay, too).

2) If we stop all the user proceses and all the kernel threads, is
that enough to prevent XFS from writing to disk?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
