Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933145AbWKMXJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbWKMXJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbWKMXJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:09:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2996 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933142AbWKMXJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:09:51 -0500
Date: Tue, 14 Nov 2006 00:09:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zan Lynx <zlynx@acm.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061113230939.GC1894@elf.ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <200611130642.18990.arvidjaar@mail.ru> <20061113081528.GB18022@suse.de> <200611132154.38644.arvidjaar@mail.ru> <1163455396.9482.38.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163455396.9482.38.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The idea is nice; unfortunately it fails to explain the difference 
> > between 'poweroff' and 'suspend disk' cases. I doubt disk layout is changed 
> > between them.
> 
> I have not checked if this is true, but it is a possible explanation:
> 
> Perhaps the filesystem is not properly unmounted during a suspend?

We do not/can not unmount filesystems during suspend. But we do sync
them.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
