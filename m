Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWHBNpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWHBNpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHBNpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 09:45:11 -0400
Received: from [212.76.87.229] ([212.76.87.229]:56337 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751129AbWHBNpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 09:45:09 -0400
From: Al Boldi <a1426z@gawab.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Wed, 2 Aug 2006 16:46:11 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <20060801210222.GC7601@ucw.cz>
In-Reply-To: <20060801210222.GC7601@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200608021646.11311.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Wed 26-07-06 22:06:48, Al Boldi wrote:
> > swsusp is really great, most of the time.  But sometimes it hangs after
> > coming out of STR.  I suspect it's got something to do with display
> > access, as this problem seems hw related.  So I removed the display
> > card, and it positively does not resume from ram on 2.6.16+.
> >
> > Any easy fix for this?
>
> Nothing easy.
>
> Can you confirm that it still hangs with init=/bin/bash, then echo 3 >
> /proc/acpi/sleep, no acpi_sleep options?

Still hangs.

Thanks for looking into this!

--
Al

