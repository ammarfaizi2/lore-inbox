Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTLDKvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLDKvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:51:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25027 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261788AbTLDKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:51:32 -0500
Date: Thu, 4 Dec 2003 11:51:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: My current suspend bigdiff
Message-ID: <20031204105131.GB11044@atrey.karlin.mff.cuni.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720BFE@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720BFE@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This is how my current "bigdiff" looks... [This is not for
> >application, but if you want to make S3 working, it might help you].
> 
> I have some issues about entering S3. From device driver point of view,  
> Could you please explain the main difference between entering S1 and
>S3.

For S1, suspending/resuming drivers is not neccessary according to the
spec. But we do it anyway. So from device driver point of view, S1 and
S3 should be the same.

If the driver has no suspend support, it will survive S1 (if you don't
have buggy hardware); that is not the case with S3.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
