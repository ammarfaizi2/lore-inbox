Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVIFOLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVIFOLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVIFOLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:11:42 -0400
Received: from tim.rpsys.net ([194.106.48.114]:34530 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964861AbVIFOLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:11:41 -0400
Subject: Re: [patch] Fix compilation in locomo.c
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050904113351.B30509@flint.arm.linux.org.uk>
References: <20050726063043.GI8684@elf.ucw.cz>
	 <20050904113351.B30509@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 15:11:25 +0100
Message-Id: <1126015886.8338.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-04 at 11:33 +0100, Russell King wrote:
> On Tue, Jul 26, 2005 at 08:30:43AM +0200, Pavel Machek wrote:
> > Do not access children in struct device directly, use
> > device_for_each_child helper instead. It fixes compilation.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> Given up waiting for John/Richard to okay this, applied anyway.

You did get a response from me on 20/8/05 which said:

"Locomo is outside my area of expertise and its not present on the
devices I use/maintain, hence this is something John would have the
definitive opinion on. The patch looks sane to me though."

I suspect John is between email addresses at the moment. Hopefully he'll
be back with us soon.

Richard

