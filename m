Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWAPM31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWAPM31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWAPM31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:29:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750709AbWAPM30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:29:26 -0500
Date: Mon, 16 Jan 2006 13:31:12 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-ID: <20060116123112.GZ3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13 2006, Randy.Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add ata_acpi in Makefile and Kconfig.
> Add ACPI obj_handle.
> Add ata_acpi.c to libata kernel-doc template file.

Randy,

Any chance you can add PATA support as well for this? Many of the
notebooks out there with SATA controllers really have PATA devices
behind a bridge, I think it's pretty much a pre-requisite for this to be
considered complete that this is supported as well. The code should be
the same, it just needs to lookup the right taskfiles. Right now on this
T43, it finds nothing.

-- 
Jens Axboe

