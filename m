Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRKTAtL>; Mon, 19 Nov 2001 19:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280807AbRKTAtC>; Mon, 19 Nov 2001 19:49:02 -0500
Received: from [202.135.142.196] ([202.135.142.196]:30736 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S280805AbRKTAs5>; Mon, 19 Nov 2001 19:48:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more fun with procfs (netfilter) 
In-Reply-To: Your message of "Mon, 19 Nov 2001 02:13:20 CDT."
             <Pine.GSO.4.21.0111190156140.17210-100000@weyl.math.psu.edu> 
Date: Tue, 20 Nov 2001 11:48:56 +1100
Message-Id: <E165z5s-0000SM-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0111190156140.17210-100000@weyl.math.psu.edu> you wri
te:
> Reason: netfilter procfs files try to fit entire records into the user
> buffer.  Do a read shorter than record size and you've got zero.  And
> read() returning 0 means you-know-what...

Yes.  Don't do this.

Hope that helps,
Rusty.
--
Premature optmztion is rt of all evl. --DK
