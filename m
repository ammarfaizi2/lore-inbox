Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUAPCyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUAPCyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:54:19 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:3416 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265230AbUAPCyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:54:13 -0500
Date: Thu, 15 Jan 2004 18:54:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115185400.31c9d670.pj@sgi.com>
In-Reply-To: <20040115170624.2851e19a.akpm@osdl.org>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115145357.1033d65a.pj@sgi.com>
	<20040115170624.2851e19a.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the feedback, Andrew.

Two points you made that I now agree with:

 * Better that this code uses existing arch-dependent bitops,
   than that it have code pretending to be generic hiding
   additional arch specific dependencies.

 * Having just realized that the other existing include/bitmap.h
   calls take a count of bits, not bytes, I now agree with you
   and Joe that it should be bit counts.


> You can never provide too many comments!

Good - I'm on solid ground there ;)


> Anyway, please wake me up again when you and Joe have finished.

ok

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
