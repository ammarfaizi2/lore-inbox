Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBHSZu>; Thu, 8 Feb 2001 13:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRBHSZl>; Thu, 8 Feb 2001 13:25:41 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:60289 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129156AbRBHSZ0>; Thu, 8 Feb 2001 13:25:26 -0500
Date: Thu, 8 Feb 2001 10:24:35 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ruffian IRQs, OSF syscalls dedugging fixes
Message-ID: <20010208102435.B3901@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010208144119.A2998@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010208144119.A2998@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Feb 08, 2001 at 02:41:19PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 02:41:19PM +0300, Ivan Kokshaysky wrote:
> - Don't trust IRQs assigned by ARC console on ruffian any more;
>   use interrupt routing table provided by <kelvin@qantel.com> instead.
>   This fixes cards reporting bogus interrupt pin (ES1969).

Oh cool.  I think this was the only one we were missing.

> - Disable debugging messages for OSF syscalls as potential source of
>   DoS attack. Besides, the same info can be obtained with `strace'.
> 
> Patches for 2.2 and 2.4 attached.

Forwarded to Linus for 2.4; Alan, this looks good for 2.2.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
