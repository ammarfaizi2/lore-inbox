Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCMIFr>; Wed, 13 Mar 2002 03:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292694AbSCMIF1>; Wed, 13 Mar 2002 03:05:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:61272 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292688AbSCMIFY>; Wed, 13 Mar 2002 03:05:24 -0500
Date: Wed, 13 Mar 2002 09:06:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313090646.F21589@dualathlon.random>
In-Reply-To: <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>, <3C8E98B2.159FA546@zip.com.au> <20020313083055.D21589@dualathlon.random> <3C8F05EF.F958B07C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8F05EF.F958B07C@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:55:27PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > What do you think about this patch against 2.4.19pre3aa1?
> 
> Well it won't apply on 10_vm-30, but that's OK...

Yes, I will make a new vm-31 shortly anyways.

> So BH_Launder is set when we start I/O and is cleared on
> I/O completion.   That sounds fine - clearly it is always
> safe to throttle on these buffers.
> 
> Thanks - I'll stress-test it tomorrow.

Fine, thanks again!

Andrea
