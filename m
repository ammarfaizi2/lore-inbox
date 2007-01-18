Return-Path: <linux-kernel-owner+w=401wt.eu-S1750840AbXAROAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXAROAV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXAROAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:00:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4389 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750840AbXAROAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:00:20 -0500
Date: Thu, 18 Jan 2007 14:00:10 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Roy Huang <royhuang9@gmail.com>
Cc: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] Provide an interface to limit total page cache.
Message-ID: <20070118140009.GA4814@ucw.cz>
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A patch provide a interface to limit total page cache in
> /proc/sys/vm/pagecache_ratio. The default value is 90 
> percent. Any
> feedback is appreciated.

Are you sure percentage is right thing to use? 1% of 200GB machine is
2GB... granularity seems too big here. KB? parts per million?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
