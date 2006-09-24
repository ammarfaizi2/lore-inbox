Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWIXJI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWIXJI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWIXJI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:08:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751812AbWIXJI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:08:59 -0400
Date: Sun, 24 Sep 2006 11:08:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: usb still sucks battery in -rc7-mm1
Message-ID: <20060924090858.GA1852@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I made some quick experiments, and usb still eats 4W of battery
power. (With whole machine eating 9W, that's kind of a big deal)...

This particular machine has usb bluetooth, but it can be disabled by
firmware, and appears unplugged. (I did that). It also has fingerprint
scanner, that can't be disabled, but that does not have driver (only
driven by useland, and was unused in this experiment).

Any ideas?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
