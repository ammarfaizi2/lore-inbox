Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbRGWQvL>; Mon, 23 Jul 2001 12:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbRGWQvB>; Mon, 23 Jul 2001 12:51:01 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35930 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268293AbRGWQur>; Mon, 23 Jul 2001 12:50:47 -0400
Date: Mon, 23 Jul 2001 18:51:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723185129.S822@athlon.random>
In-Reply-To: <200107230508.AAA04621@ccure.karaya.com> <20010723175635.L822@athlon.random> <20010723175907.N822@athlon.random> <20010723181711.Q822@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010723181711.Q822@athlon.random>; from andrea@suse.de on Mon, Jul 23, 2001 at 06:17:11PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 06:17:11PM +0200, Andrea Arcangeli wrote:
> On Mon, Jul 23, 2001 at 05:59:07PM +0200, Andrea Arcangeli wrote:
> > On Mon, Jul 23, 2001 at 05:56:35PM +0200, Andrea Arcangeli wrote:
> > > BTW, Linus the _below_ patches against mainline are needed to compile
> > > the x86 port with gcc-3_0-branch of yesterday, it is safe to include it
> > > in mainline:
> > 
> > here another one for reiserfs:
> 
> here another one:

another one:

--- 2.4.7aa1/drivers/net/arlan.c.~1~	Sat Jul 21 00:04:15 2001
+++ 2.4.7aa1/drivers/net/arlan.c	Mon Jul 23 18:46:35 2001
@@ -1435,7 +1435,7 @@
 	ARLAN_DEBUG_EXIT("arlan_queue_retransmit");
 };
 
-extern inline void RetryOrFail(struct net_device *dev)
+static inline void RetryOrFail(struct net_device *dev)
 {
 	struct arlan_private *priv = ((struct arlan_private *) dev->priv);
 

Andrea
