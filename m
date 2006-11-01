Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946870AbWKANV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946870AbWKANV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946871AbWKANV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:21:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28555 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946870AbWKANV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:21:26 -0500
Date: Wed, 1 Nov 2006 14:21:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
       Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Message-ID: <20061101132114.GB2567@elf.ucw.cz>
References: <200611011323.14830.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611011323.14830.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-11-01 13:23:14, Rafael J. Wysocki wrote:
> It has been reported that on some systems the functionality after a resume
> from disk is limited if the system is simply powered off during the suspend
> instead of using the ACPI S4 suspend (aka platform mode).
> 
> Unfortunately the default is currently to power off the system during the
> suspend so the users of these systems experience problems after the resume
> if they don't switch to the platform mode explicitly.  This patch makes swsusp
> use the platform mode by default to avoid such situations.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
