Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWJWPSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWJWPSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWJWPSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:18:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30675 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964932AbWJWPSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:18:52 -0400
Date: Mon, 23 Oct 2006 17:18:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
Message-ID: <20061023151845.GB8414@elf.ucw.cz>
References: <1161560896.7438.67.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161560896.7438.67.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Modify process thawing so that we can thaw kernel space without thawing
> userspace, and thaw kernelspace first. This will be useful in later
> patches, where I intend to get swsusp thawing kernel threads only before
> seeking to free memory.
> 
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

NAK. "May be useful in future" is not good reason to merge it now. (If
you did not want it merged, just mark it so).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
