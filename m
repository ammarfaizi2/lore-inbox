Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269544AbRHGVgU>; Tue, 7 Aug 2001 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269476AbRHGVgK>; Tue, 7 Aug 2001 17:36:10 -0400
Received: from [63.209.4.196] ([63.209.4.196]:37647 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269473AbRHGVf4>; Tue, 7 Aug 2001 17:35:56 -0400
Date: Tue, 7 Aug 2001 14:34:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kupdated oops in 2.4.8-pre5
In-Reply-To: <Pine.LNX.4.33.0108072325230.1930-100000@ppro.localdomain>
Message-ID: <Pine.LNX.4.33.0108071433480.1434-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Aug 2001, Peter Osterlund wrote:
>
> I got the following oops with kernel 2.4.8-pre5. bh becomes NULL in
> sync_old_buffers() but the code tries to dereference it anyway.

Yes, stupid lost test. Already fixed in -pre6.

		Linus "fast than you can download one kernel" Torvalds

