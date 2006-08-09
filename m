Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHIMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHIMbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWHIMbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:31:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9887 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750717AbWHIMbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:31:08 -0400
Date: Wed, 9 Aug 2006 14:30:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Message-ID: <20060809123052.GB3808@elf.ucw.cz>
References: <200608091426.31762.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091426.31762.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> It looks like the CMOS clock gets corrupted during the suspend to disk
> on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> AMD64-based and the x86_64 kernel doesn't have this problem on it.
> 
> Also, I've done some tests that indicate the corruption doesn't occur before
> saving the suspend image.  It rather happens when the box is powered off
> or rebooted (tested both cases).
> 
> Unfortunately, I have no more time to debug it further right now.

Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
:-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
