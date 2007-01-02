Return-Path: <linux-kernel-owner+w=401wt.eu-S932691AbXABKdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbXABKdA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXABKdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:33:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58283 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932691AbXABKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:32:59 -0500
Date: Tue, 2 Jan 2007 11:32:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: 2.6.20 regression: suspend to disk no more works
Message-ID: <20070102103251.GD2122@elf.ucw.cz>
References: <200701012244.42781.arvidjaar@mail.ru> <200701020028.19866.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701020028.19866.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > While 'echo a:b > /sys/power/resume' before 
> > suspend is a workaround, this still breaks perfectly valid setup that worked
> > before. Also 'echo a:b > /sys/power/resume' is actually wrong - we are not
> > going to resume at this point; but there is no way to just tell kernel "use
> > this device for next STD" ... also the error message is misleading, it should
> > complaint "no resume device found". Swap is there all right.
> 
> Thanks for the report.

It fixes it for too people, I guess that's ACK... certainly for -mm,
probably for 2.6.20, too.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
