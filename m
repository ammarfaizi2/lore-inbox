Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTGXQ6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271723AbTGXQ6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:58:14 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:51369
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271721AbTGXQ5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:57:45 -0400
Date: Thu, 24 Jul 2003 13:12:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA HD 137GB limitation?
Message-ID: <20030724171253.GD5695@gtf.org>
References: <3F1F33B0.4070701@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1F33B0.4070701@bigfoot.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 06:17:36PM -0700, Erik Steffl wrote:
>   system:
> 
>   MB: intel D865PERL
>   maxtor 250GB SATA drive (not a boot drive)
>   kernel 2.4.21-ac4
>   debian unstable
> 
>   normal kernels up to 2.4.21 freeze during HD detection, only 
> 2.4.21-ac4 properly detects the drive. All programs (mkfs, badblocks, 
> cfdisk) recognize it as 250GB drive but none of them can read anything 
> beyond 137GB. All programs (that I tried) report read failure when 
> sectors above 137GB are being read.
> 
>   anybody knows the status of SATA driver(s)?

Is this with CONFIG_SCSI_ATA or drivers/ide driver?

	Jeff



