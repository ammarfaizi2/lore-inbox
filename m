Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVAaLGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVAaLGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVAaLGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:06:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25783 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261855AbVAaLF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:05:56 -0500
Date: Mon, 31 Jan 2005 12:05:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>, dougg@torque.net
Subject: Re: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
Message-ID: <20050131110550.GA5058@suse.de>
References: <200501310034.32005.cova@ferrara.linux.it> <20050131080021.GA9446@suse.de> <200501311108.19593.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501311108.19593.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31 2005, Fabio Coatti wrote:
> Alle 09:00, lunedì 31 gennaio 2005, Jens Axboe ha scritto:
> >
> > > At this point k3b is stuck in D stat, needs reboot.
> >
> > The most likely suspect is the REQ_BLOCK_PC scsi changes. Can you try
> > 2.6.11-rc2-mm1 with bk-scsi backed out? (attached)
> 
> just tried, right guess :)
> backing out that patch the problem disappears.
> Let me know if you need to narrow further that issue.

Doug, it looks like your REQ_BLOCK_PC changes are buggy. Let me know if
you cannot find the full post and I'll forward it to you.

-- 
Jens Axboe

