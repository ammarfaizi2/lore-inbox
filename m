Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTJ0Q6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTJ0Q6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:58:13 -0500
Received: from havoc.gtf.org ([63.247.75.124]:43958 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263382AbTJ0Q6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:58:10 -0500
Date: Mon, 27 Oct 2003 11:58:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Patrik Wallstrom <pawal@blipp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA and 2.6.0-test9
Message-ID: <20031027165809.GD19711@gtf.org>
References: <20031027141531.GD15558@vic20.blipp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027141531.GD15558@vic20.blipp.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 03:15:32PM +0100, Patrik Wallstrom wrote:
> > Jeff Garzik:
> >   o [libata] Merge Serial ATA core, and drivers for
> >   o [libata] Integrate Serial ATA driver into kernel tree
> 
> I am happy to see these in the kernel now, but I have yet to get them
> working on my KT6 Delta KT600 motherboard with the VT8237 SATA
> southbridge controller or even the Promise controller.

Does it improve things, if you change ATA_FLAG_SRST to
ATA_FLAG_SATA_RESET, in drivers/scsi/sata_via.c ?

	Jeff



