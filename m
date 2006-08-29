Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965364AbWH2VDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbWH2VDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965363AbWH2VDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:03:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8583 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965323AbWH2VDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:03:30 -0400
Date: Tue, 29 Aug 2006 23:03:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH -mm] Make it possible to disable serial console suspend
Message-ID: <20060829210318.GA21678@elf.ucw.cz>
References: <200608292152.43915.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608292152.43915.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-08-29 21:52:43, Rafael J. Wysocki wrote:
> Hack uart_suspend_port() and uart_resume_port() so that serial console ports
> are not suspended if CONFIG_DISABLE_CONSOLE_SUSPEND is set.
> 
> This makes it possible to debug the suspend and resume routines of all device
> drivers as well as the lowest-level swsusp code with the help of the serial
> console.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks good to me, ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
