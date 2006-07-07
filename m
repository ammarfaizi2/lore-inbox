Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWGGKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWGGKuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWGGKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:50:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40670 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932109AbWGGKuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:50:54 -0400
Date: Fri, 7 Jul 2006 12:50:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc1: breaks boot on thinkpad x32
Message-ID: <20060707105041.GA1656@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to update to 2.6.18-rc1-git, but got hang after

acpiphp: Slot [1] registered

...but acpi=off failed to workaround the problem, it merely hung at
another place. I went back to 2.6.18-rc1, and it hung at same
place. 2.6.17 works. Any ideas?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
