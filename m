Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVBQLA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVBQLA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 06:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVBQLA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 06:00:58 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:23494 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261394AbVBQLAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 06:00:53 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <1108621005.2096.412.camel@d845pe>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108621005.2096.412.camel@d845pe>
Date: Thu, 17 Feb 2005 11:00:21 +0000
Message-Id: <1108638021.4085.143.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] Call for help: list of machines with working S3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 01:16 -0500, Len Brown wrote:
> Pavel,
> I think that it is the BIOS' job on S3-suspend
> to save the video mode.  On S3-resume the BIOS should
> re-POST and restore the video mode.

I agree, but in the absence of spec requirement and some form of
certification process, I don't see it happening in the near future.
Given that vendors are still shipping invalid DSDTs, if Windows is able
to reinitialise the graphics hardware, few are going to care about
making life easier for Linux.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

