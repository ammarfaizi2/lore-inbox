Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAZKdh>; Fri, 26 Jan 2001 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131274AbRAZKd2>; Fri, 26 Jan 2001 05:33:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129431AbRAZKdU>;
	Fri, 26 Jan 2001 05:33:20 -0500
Date: Fri, 26 Jan 2001 11:28:11 +0100
From: Jens Axboe <axboe@suse.de>
To: qkholland@my-deja.com
Cc: linux-kernel@vger.kernel.org, Mark Bratcher <mbratche@rochester.rr.com>
Subject: Re: Kernel 2.4.0 loop device still hangs
Message-ID: <20010126112811.E12520@suse.de>
In-Reply-To: <fa.hl5rjsv.1b78u0u@ifi.uio.no> <200101260634.AAA02715@x57.deja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101260634.AAA02715@x57.deja.com>; from qkholland@my-deja.com on Fri, Jan 26, 2001 at 06:34:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26 2001, qkholland@my-deja.com wrote:
>   Mark Bratcher <mbratche@rochester.rr.com> wrote:
> > I saw a post dated last fall 2000 sometime about the
> > loop device hanging when copying large amounts of data
> > to a file mounted as, say, ext2fs.
> 
> I've recently reported a similar problem and told by
> Jens Axboe at SUSE that it is still there, and appears
> to be generic (not hardware nor kernel configuration
> specific) problem.

Yes, and please try:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.1-pre10/loop-3

and see if you can reproduce.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
