Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbRGWObw>; Mon, 23 Jul 2001 10:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268242AbRGWObm>; Mon, 23 Jul 2001 10:31:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:46654 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268239AbRGWObY>; Mon, 23 Jul 2001 10:31:24 -0400
Date: Mon, 23 Jul 2001 16:31:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010723163145.E822@athlon.random>
In-Reply-To: <20010723013416.B23517@athlon.random> <m15Obfk-000CD5C@localhost> <15196.4844.322398.502850@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15196.4844.322398.502850@pizda.ninka.net>; from davem@redhat.com on Mon, Jul 23, 2001 at 05:05:00AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 05:05:00AM -0700, David S. Miller wrote:
> 
> Rusty Russell writes:
>  > In message <20010723013416.B23517@athlon.random> you write:
>  > > What kernel are you looking at? There's no such code in 2.4.7, the only
>  > 
>  > Oh, so it's only a trap *waiting* to happen.  That's OK then!
>  ...
>  > Why not fix all the cases?  Why have this wierd secret rule that
>  > cpu_raise_softirq() should not be called with irqs disabled?
> 
> Why keep it secret?  I think Andrea is exactly right here, and we
> should just comment this restriction.  That's all.

there's not such restriction as far I can tell (see my previous email
for details).

Andrea
