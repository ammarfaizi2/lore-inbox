Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUBWDMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUBWDMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:12:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:60358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbUBWDMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:12:30 -0500
Date: Sun, 22 Feb 2004 19:13:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
Message-Id: <20040222191313.19231879.akpm@osdl.org>
In-Reply-To: <40396E8F.4050307@realitydiluted.com>
References: <40396134.6030906@realitydiluted.com>
	<20040222190047.01f6f024.akpm@osdl.org>
	<40396E8F.4050307@realitydiluted.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven J. Hill" <sjhill@realitydiluted.com> wrote:
>
> Andrew Morton wrote:
> > 
> >>+config BLK_DEV_SR_PARTITIONS
> >>+config BLK_DEV_SR_PARTITIONS_PER_DEVICE
> > 
> > 
> > Do we actually need these config options?  Why not hardwire it to some
> > reasonable upper bound and be done with it?
> >
> I have no problem hardwiring the number of partitions, but the
> BLK_DEV_SR_PARTITIONS should still be an option to allow the
> user to decided if they want partitioning support for their
> SCSI CDROMs. Or are you suggesting that from now on partitions
> will be supported by default?

Well we need to be able to handle both types at runtime anyway, and the
amount of added code is tiny.

