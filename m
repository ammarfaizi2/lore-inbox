Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268207AbRGWMFV>; Mon, 23 Jul 2001 08:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268208AbRGWMFL>; Mon, 23 Jul 2001 08:05:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62597 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268207AbRGWMFI>;
	Mon, 23 Jul 2001 08:05:08 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.4844.322398.502850@pizda.ninka.net>
Date: Mon, 23 Jul 2001 05:05:00 -0700 (PDT)
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness. 
In-Reply-To: <m15Obfk-000CD5C@localhost>
In-Reply-To: <20010723013416.B23517@athlon.random>
	<m15Obfk-000CD5C@localhost>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Rusty Russell writes:
 > In message <20010723013416.B23517@athlon.random> you write:
 > > What kernel are you looking at? There's no such code in 2.4.7, the only
 > 
 > Oh, so it's only a trap *waiting* to happen.  That's OK then!
 ...
 > Why not fix all the cases?  Why have this wierd secret rule that
 > cpu_raise_softirq() should not be called with irqs disabled?

Why keep it secret?  I think Andrea is exactly right here, and we
should just comment this restriction.  That's all.

Later,
David S. Miller
davem@redhat.com
