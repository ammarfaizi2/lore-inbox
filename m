Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270042AbUJHQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270042AbUJHQCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270054AbUJHQBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:01:35 -0400
Received: from havoc.gtf.org ([69.28.190.101]:6803 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S270042AbUJHPx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:53:26 -0400
Date: Fri, 8 Oct 2004 11:49:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
Message-ID: <20041008154919.GA12107@havoc.gtf.org>
References: <4165A766.1040104@pobox.com> <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org> <1097241583.2412.15.camel@mulgrave> <4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> <4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097250465.2412.49.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 10:47:40AM -0500, James Bottomley wrote:
> However, I assume you know you can't sleep in queuecommand since it may
> be run from the scsi tasklet?

Furthermore queuecommand is inside spin_lock_irqsave

	Jeff


