Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFGNJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFGNJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 09:09:41 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263185AbTFGNJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 09:09:40 -0400
Date: Sat, 7 Jun 2003 14:23:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, davidm@hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030607142305.A27242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, rmk@arm.linux.org.uk,
	davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <20030606.234401.104035537.davem@redhat.com> <16097.37454.827982.278024@napali.hpl.hp.com> <20030607104434.B22665@flint.arm.linux.org.uk> <20030607.024704.13764413.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030607.024704.13764413.davem@redhat.com>; from davem@redhat.com on Sat, Jun 07, 2003 at 02:47:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 02:47:04AM -0700, David S. Miller wrote:
> I agree, the idea at the time that Jens and myself did this
> work was that the generic device layer would provide interfaces
> by which we could test this given a struct device.

Wouldn't that be the dma_is_phys(dev) call I mentioned earlier in
this thread that you didn't like? :)

