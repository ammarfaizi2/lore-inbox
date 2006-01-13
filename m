Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423056AbWAMWjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbWAMWjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161577AbWAMWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:39:31 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:61666 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161576AbWAMWja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:39:30 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060113220215.GD31824@flint.arm.linux.org.uk>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <20060113220215.GD31824@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 16:38:49 -0600
Message-Id: <1137191930.3365.96.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 22:02 +0000, Russell King wrote:
> Unfortunately, as I previously explained, I'm not able to test this.
> The reason is that in order to reproduce the bug, you need a system
> with a VIVT write-back write-allocate cache.
> 
> Unfortunately, the few systems I have which have such a cache do not
> have IDE, SCSI nor SATA (not even PCMCIA.)  I suggest contacting the
> folk who reported the bug in the first instance.

Could someone explain (or give a reference to) the actual problem?  If
it's a cache coherency issue it should show up with VIPT arhictectures
as well as VIVT ones ... I have access to parisc systems (with SCSI),
which are VIPT.

James


