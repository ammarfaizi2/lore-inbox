Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVBQKOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVBQKOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 05:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVBQKOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 05:14:37 -0500
Received: from styx.suse.cz ([82.119.242.94]:56023 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262292AbVBQKOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 05:14:34 -0500
Date: Thu, 17 Feb 2005 11:15:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217101533.GA15721@ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108621005.2096.412.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 01:16:45AM -0500, Len Brown wrote:

> Pavel,
> I think that it is the BIOS' job on S3-suspend
> to save the video mode.  On S3-resume the BIOS should
> re-POST and restore the video mode.

Should.

But this definitely is not the case on about 80+% of notebooks.

You can save the video state through VESA VBE, and restore it on resume,
but if the BIOS didn't re-POST the video, this will often fail.

> While Linux's X drivers may be able to handle the case
> where X is running -- that doesn't help us with the
> cases where X is not running (a case that Windows
> presumably does not have).
> 
> Besides updated X drivers, which may have complicated
> restore routines for complicated modes, all the other
> techniques for restoring video from Linux are
> hit/miss workarounds for broken platforms.
> 
> To completely solve the Linux S3 video restore issue,
> we need to push the platform and BIOS vendors.

That's correct.

> What am I missing?
 
I'm not sure if you can push the whole industry at once.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
