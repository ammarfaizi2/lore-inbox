Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKHRjA>; Wed, 8 Nov 2000 12:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQKHRiu>; Wed, 8 Nov 2000 12:38:50 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:18439 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129210AbQKHRin>; Wed, 8 Nov 2000 12:38:43 -0500
Date: Wed, 8 Nov 2000 09:37:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108093744.D27324@twiddle.net>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001108142513.A5244@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 02:25:13PM +0300, Ivan Kokshaysky wrote:
> I relied on DEC^WIntel 21153 datasheet which says that to turn off
> io/mem window this bridge must be programmed with base > limit
> values (and the code actually did that).

Interesting.  I hadn't known that.  It didn't actually fail with
the ALI bridge, I just assumed it was a mistake.  Can anyone with
docs on non-DEC bridges confirm that this is a common thing?

Certainly the fact should be commented if the old code goes back
in to avoid disruption by helpful folks like myself.  :-)


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
