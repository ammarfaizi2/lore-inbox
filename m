Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVBQLDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVBQLDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 06:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBQLDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 06:03:25 -0500
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:29129 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262177AbVBQLCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 06:02:50 -0500
Date: Thu, 17 Feb 2005 12:02:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217110233.GA1353@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108621005.2096.412.camel@d845pe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think that it is the BIOS' job on S3-suspend
> to save the video mode.  On S3-resume the BIOS should
> re-POST and restore the video mode.

Can you find it written down somewhere? It would be certainly easier
for me if every BIOS did re-post, but it is not the case on any new
BIOS....

> To completely solve the Linux S3 video restore issue,
> we need to push the platform and BIOS vendors.
> 
> What am I missing?

I think we are missing few lines in docs somewhere saying "video must
be re-POSTed during S3 wakeup". And then we miss someone going around
vendors with baseball bat, telling them to fix their BIOSes.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
