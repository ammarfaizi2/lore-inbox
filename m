Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBGV4O>; Wed, 7 Feb 2001 16:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbRBGV4K>; Wed, 7 Feb 2001 16:56:10 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:38926 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129092AbRBGVz5>; Wed, 7 Feb 2001 16:55:57 -0500
Date: Wed, 07 Feb 2001 16:55:26 -0500
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>, Xuan Baldauf <xuan--reiserfs@baldauf.org>
cc: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <707700000.981582926@tiny>
In-Reply-To: <20010208104729.B4749@metastasis.f00f.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 08, 2001 10:47:29 AM +1300 Chris Wedgwood
<cw@f00f.org> wrote:

> these appear on your system every couple of days right? if so... are
> you able to run with the fs mount notails for a couple of days and
> see if you still experience these?
> 
> my guess is you probably still will as most log files aren't
> candidates for tail-packing (too large) but it will help eliminate
> one more thing....
> 

Yes, it really would.

1) mount -o notail
2) rm old_logfile
3) restart syslog

This will ensure the log files don't have tails at all.  Knowing for sure
the bug doesn't involve tails would remove much code from the search.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
