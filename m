Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWAPPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWAPPhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWAPPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:37:33 -0500
Received: from xenotime.net ([66.160.160.81]:28293 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750859AbWAPPhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:37:33 -0500
Date: Mon, 16 Jan 2006 07:37:27 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jens Axboe <axboe@suse.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
In-Reply-To: <20060116123112.GZ3945@suse.de>
Message-ID: <Pine.LNX.4.58.0601160736360.24990@shark.he.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116123112.GZ3945@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Jens Axboe wrote:

> On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >
> > Add ata_acpi in Makefile and Kconfig.
> > Add ACPI obj_handle.
> > Add ata_acpi.c to libata kernel-doc template file.
>
> Randy,
>
> Any chance you can add PATA support as well for this? Many of the
> notebooks out there with SATA controllers really have PATA devices
> behind a bridge, I think it's pretty much a pre-requisite for this to be
> considered complete that this is supported as well. The code should be
> the same, it just needs to lookup the right taskfiles. Right now on this
> T43, it finds nothing.

I'll add that to my list but I don't yet think that it's quite
as simple as you make it sound...

-- 
~Randy
