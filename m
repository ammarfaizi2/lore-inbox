Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTEHLtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTEHLtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:49:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47846 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261360AbTEHLtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:49:16 -0400
Date: Thu, 8 May 2003 14:01:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508120145.GR823@suse.de>
References: <20030507175033.GR823@suse.de> <Pine.SOL.4.30.0305072119530.27561-100000@mion.elka.pw.edu.pl> <20030507201949.GW823@suse.de> <20030508075609.GJ823@suse.de> <1052391717.10037.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052391717.10037.5.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Alan Cox wrote:
> On Iau, 2003-05-08 at 08:56, Jens Axboe wrote:
> > That part is added, I still kept it at 65535 though akin to how we don't
> > use that last sector in 28-bit commands either. For 48-bit commands this
> > is totally irelevant, 32MiB or 32MiB-512b doesn't matter either way.
> 
> Actually I changed the LBA28 code to use the last sector a while ago. It
> has (unsuprisingly) caused zero problems because other OS's also
> generate such requests.

That's great, if you remember that was my requirement for usage of the
last sector, that the Other OS used it. If it does, it can't be buggy.

-- 
Jens Axboe

