Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVBQGSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVBQGSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVBQGSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:18:12 -0500
Received: from fmr16.intel.com ([192.55.52.70]:59316 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262236AbVBQGSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:18:04 -0500
Subject: Re: [ACPI] Call for help: list of machines with working S3
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1108621005.2096.412.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2005 01:16:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,
I think that it is the BIOS' job on S3-suspend
to save the video mode.  On S3-resume the BIOS should
re-POST and restore the video mode.

While Linux's X drivers may be able to handle the case
where X is running -- that doesn't help us with the
cases where X is not running (a case that Windows
presumably does not have).

Besides updated X drivers, which may have complicated
restore routines for complicated modes, all the other
techniques for restoring video from Linux are
hit/miss workarounds for broken platforms.

To completely solve the Linux S3 video restore issue,
we need to push the platform and BIOS vendors.

What am I missing?

thanks,
-Len


