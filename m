Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWHMVWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWHMVWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHMVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:22:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41361 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751470AbWHMVV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:21:59 -0400
Date: Sun, 13 Aug 2006 23:21:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH -mm 0/2] Detect clock skew during suspend
Message-ID: <20060813212131.GA6231@elf.ucw.cz>
References: <200608132303.00012.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608132303.00012.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If the CMOS timer is changed when the system is suspended to disk in such a
> way that the time during the resume turns out to be earlier than the time
> before the suspend, the resume often fails and the system hangs (spins
> forever in the idle thread) due to driver problems.
> 
> For this reason it seems reasonable to make the timer .resume() routines
> detect such situations and prevent them from happening, which is done
> in the following two patches for i386 and x86_64.

"Clock skew detected"... Maybe "time going backwards detected" ?

Anyway, patches look good to me, ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
