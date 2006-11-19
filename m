Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933321AbWKSVRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbWKSVRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933330AbWKSVRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:17:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30397 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933321AbWKSVR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:17:29 -0500
Date: Sun, 19 Nov 2006 22:17:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/4] swsusp: Untangle freeze_processes
Message-ID: <20061119211711.GE23230@elf.ucw.cz>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.16692.rjw@sisk.pl> <20061119020926.GD15873@elf.ucw.cz> <200611191305.02250.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611191305.02250.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Needs space between if and (, but lets use if (is_user_space() !=
> > freeze_user_space) trick here, too.
> 
> OK
> 
> New version of the patch follows.
> 
> ---
> Move the loop from freeze_processes() to a separate function and call it
> independently for user space processes and kernel threads so that the order of
> freezing tasks is clearly visible.

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
