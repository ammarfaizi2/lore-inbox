Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUIRIcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUIRIcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 04:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIRIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 04:31:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56963 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269164AbUIRIax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 04:30:53 -0400
Date: Sat, 18 Sep 2004 10:30:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
Message-ID: <20040918083047.GB1195@suse.de>
References: <20040914061641.GD2336@suse.de> <20040917141004.GA467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917141004.GA467@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17 2004, Pavel Machek wrote:
> Hi!
> 
> > 2.6.9-rc2 is throwing a lot of these errors on my system:
> > 
> > [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
> > [ACPI Debug] String: Length 0x0F, "Entering TIN2()"
> > [ACPI Debug] String: Length 0x0F, "Existing RTMP()"
> > 
> > About 450 of these three lines repeated so far, seem to get one every 5
> > seconds or so. Box is an Athlon64 solo, let me know if you want more
> > info (and what).
> > 
> 
> That seems to be normal. These are debug prints from ACPI BIOS.

3 lines of dmesg every 5 seconds isn't quite optimal... But Len already
guided me to the acpi debug disable, which shuts it up.

-- 
Jens Axboe

