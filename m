Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267470AbUIPFrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUIPFrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIPFrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:47:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57780 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267470AbUIPFrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:47:13 -0400
Date: Thu, 16 Sep 2004 07:45:30 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040916054530.GB2300@suse.de>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com> <20040915113833.GA4111@suse.de> <20040915122852.GQ9106@holomorphy.com> <20040915124124.GC4111@suse.de> <20040915125056.GD4111@suse.de> <20040915125355.GS9106@holomorphy.com> <20040916003819.GG9106@holomorphy.com> <20040916054446.GN9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916054446.GN9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, William Lee Irwin III wrote:
> On Wed, Sep 15 2004, Jens Axboe wrote:
> >>>> Hmm, I can only see this happening if rq->flags has its direction bit
> >>>> changed between the allocation time and the time of freeing. I'll look
> >>>> over scsi and see if I can find any traces of that, don't see any
> >>>> immediately.
> 
> On Wed, Sep 15, 2004 at 02:50:57PM +0200, Jens Axboe wrote:
> >>> Can you try if this works?
> 
> On Wed, Sep 15, 2004 at 05:53:55AM -0700, William Lee Irwin III wrote:
> >> Booting it ASAP.
> 
> On Wed, Sep 15, 2004 at 05:38:19PM -0700, William Lee Irwin III wrote:
> > It appears to have lasted enough hours to call it an improvement. I'll
> > leave it running for a while longer just in case.
> 
> Okay, it got well over 8 solid hours, so I'm going to move on to booting
> something else.

Thanks for your testing, I'm concluding that it most likely fixed your
problem.

-- 
Jens Axboe

