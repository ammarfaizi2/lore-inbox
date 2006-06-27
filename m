Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWF0MKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWF0MKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWF0MKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:10:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4010 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932165AbWF0MKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:10:35 -0400
Date: Tue, 27 Jun 2006 14:07:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 1/2] [Suspend2] Disable load updating during suspending.
Message-ID: <20060627120740.GA3019@elf.ucw.cz>
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <20060626163852.10345.788.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626163852.10345.788.stgit@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suspend2 uses the cpu very intensively, with the result that the load
> average can be quite high when a cycle has just completed. This in turn can
> cause problems with mail delivery and other activities that suspend
> activities when the load average gets too high. To avoid this, we suspend
> updates of the load average while the freezer is on.

If we want to do this at all... why not simply set load average to
zero when resume is done?

After all, system probably was completely idle for quite a while :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
