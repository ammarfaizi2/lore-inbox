Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUALOO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUALOOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:14:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266185AbUALOOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:14:07 -0500
Date: Mon, 12 Jan 2004 15:13:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
Cc: Doug Ledford <dledford@redhat.com>, Arjan Van de Ven <arjanv@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112141330.GH24638@suse.de>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12 2004, Martin Peschke3 wrote:
> Hi,
> 
> is there a way to merge all (or at least the common denominator) of
> Redhat's and SuSE's changes into the vanilla 2.4 SCSI stack?
> The SCSI part of Marcelo's kernel seems to be rather backlevel,
> considering all those fixes and enhancements added by the mentioned
> distributors and their SCSI experts. As this discussion underlines,
> there are a lot of common problems and sometimes even common
> approaches.  I am convinced that a number of patches ought to be
> incorporated into the mainline kernel. Though, I must admit
> that I am at a loss with how this could be achieved given the
> unresolved question of 2.4 SCSI maintenance
> (which has certainly played a part in building up those piles
> of SCSI patches).

I have mixed feelings about that. One on side, I'd love to merge the
scalability patches in mainline. We've had a significant number of bugs
in this area in the past, and it seems a shame that we all have to fix
them independently because we deviate from mainline. On the other hand,
2.4 is pretty much closed. There wont be a big number of new distro 2.4
kernels.

Had you asked me 6 months ago I probably would have advocated merging
them, but right now I think it's a waste of time.

-- 
Jens Axboe

