Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWGJT56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWGJT56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWGJT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:57:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2541 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422689AbWGJT55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:57:57 -0400
Date: Mon, 10 Jul 2006 21:57:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, pasky@suse.cz
Subject: git, hardlinks and backups
Message-ID: <20060710195727.GA2246@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I know this may be stupid, but...

I'm backing up my linux kernel trees, and found out that backup (done
by rsync) is twice as big as original. That's quite bad... it is
because git uses hardlinks heavily but rsync can't preserve them.

I'm pretty sure someone hit this before... what is the trick?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
