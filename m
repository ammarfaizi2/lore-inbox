Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWHAVEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWHAVEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWHAVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:04:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54033 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750800AbWHAVEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:04:52 -0400
Date: Tue, 1 Aug 2006 21:02:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp hangs on headless resume-from-ram
Message-ID: <20060801210222.GC7601@ucw.cz>
References: <200607262206.48801.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607262206.48801.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-07-06 22:06:48, Al Boldi wrote:
> 
> swsusp is really great, most of the time.  But sometimes it hangs after 
> coming out of STR.  I suspect it's got something to do with display access, 
> as this problem seems hw related.  So I removed the display card, and it 
> positively does not resume from ram on 2.6.16+.
> 
> Any easy fix for this?

Nothing easy.

Can you confirm that it still hangs with init=/bin/bash, then echo 3 >
/proc/acpi/sleep, no acpi_sleep options?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
