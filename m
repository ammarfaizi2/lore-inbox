Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUHMHQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUHMHQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUHMHQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:16:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25835 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269014AbUHMHQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:16:13 -0400
Date: Fri, 13 Aug 2004 09:15:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Clayton <chris@theclaytons.giointernet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDMRW in 2.6
Message-ID: <20040813071537.GE2321@suse.de>
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091625.31210.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Chris Clayton wrote:
> cdrom: hdc: mrw address space DMA selected
> cdrom open: mrw_status 'mrw complete'
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 1048576

Command was aborted, probably the media isn't writable after all.  Can
you try and force a full format with cdrwtool?

-- 
Jens Axboe

