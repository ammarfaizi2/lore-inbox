Return-Path: <linux-kernel-owner+w=401wt.eu-S932135AbXAOXy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXAOXy7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXAOXy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:54:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15776 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122AbXAOXy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:54:58 -0500
Date: Tue, 16 Jan 2007 10:55:24 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.20-rc4-mm1
Message-ID: <20070115235524.GA4067@kernel.dk>
References: <20070111222627.66bb75ab.akpm@osdl.org> <1168768104.2941.53.camel@localhost.localdomain> <1168771617.2941.59.camel@localhost.localdomain> <1168785616.2941.67.camel@localhost.localdomain> <20070114220515.GG5860@kernel.dk> <1168813901.2941.85.camel@localhost.localdomain> <20070114223019.GP5860@kernel.dk> <20070115082219.GA9062@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115082219.GA9062@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15 2007, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > > In a previous write invoked by: fsck.ext3(1896): WRITE block 8552 on 
> > > sdb1 end_buffer_async_write() is invoked.
> > > 
> > > sdb1 is not a part of a raid device.
> > 
> > When I briefly tested this before I left (and found it broken), doing 
> > a cat /proc/mdstat got things going again. Hard if that's your rootfs, 
> > it's just a hint :-)
> 
> hm, so you knew it's broken, still you let Andrew pick it up, or am i 
> misunderstanding something?

Well the raid issue wasn't known before it was in -mm.

-- 
Jens Axboe

