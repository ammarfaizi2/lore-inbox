Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFBKcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTFBKcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:32:03 -0400
Received: from ns.suse.de ([213.95.15.193]:63245 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262153AbTFBKb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:31:57 -0400
Date: Mon, 2 Jun 2003 12:45:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: David Wilson <david@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: capability flag for ATAPI MO (from kernel mailing list)
Message-ID: <20030602104517.GH9561@suse.de>
References: <20030530015334.GD1120@uow.edu.au> <Pine.LNX.4.44.0305301130070.1076-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305301130070.1076-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30 2003, Pascal Schmidt wrote:
> On Fri, 30 May 2003, David Wilson wrote:
> 
> > Is optical (or CDC_OPTICAL) a good name for this capability?
> > After all, CD CD-R CD-RW DVD DVD+/-R(W) are all optical.
> 
> Well, I simply used something similar to ide_optical from IDE code, but
> I agree that it's not optimal.
> 
> > That said, a better name does not immediately spring to mind
> > (unless MOPTICAL works for you - magneto-optical seems too long).
> 
> I'll see what Jens has to say about the name. CDC_MOPTICAL looks ugly
> to me, and CDC_MO too short. Maybe CDC_MO_DRIVE would work if
> CDC_OPTICAL is not acceptable.

CDC_MO_DRIVE would be fine with me, it's right to the point. But
basically I don't really care, I think it's pretty clear even if named
CDC_OPTICAL.

-- 
Jens Axboe

