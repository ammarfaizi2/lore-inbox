Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRG3Wi6>; Mon, 30 Jul 2001 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268699AbRG3Wih>; Mon, 30 Jul 2001 18:38:37 -0400
Received: from [63.195.182.101] ([63.195.182.101]:28934 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S268691AbRG3Wi3>; Mon, 30 Jul 2001 18:38:29 -0400
Date: Mon, 30 Jul 2001 15:37:50 -0700
To: Bill Pringlemeir <bpringle@sympatico.ca>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
Message-ID: <20010730153750.B20766@bluemug.com>
Mail-Followup-To: Bill Pringlemeir <bpringle@sympatico.ca>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0107301646050.19391-100000@weyl.math.psu.edu> <20010730141427.E20284@bluemug.com> <m2ofq26p13.fsf@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2ofq26p13.fsf@sympatico.ca>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 06:16:40PM -0400, Bill Pringlemeir wrote:
> >>>>> "Mike" == Mike Touloumtzis <miket@bluemug.com> writes:
> [snip]
>  Mike> Hmmm, maybe we need ramfs-backed-by-romfs :-).  But a lot of
>  Mike> people in the embedded/consumer electronics space could get by
>  Mike> just fine with a read-only / and a ramfs or ramdisk on /tmp.
> 
> I am not so sure about this.  Typical flash access times are rather
> long compared to SDRAM.  StrataFlash and other bursting flash are
> rather new and require specific CPUs or custom logic to access the
> flash in a sequential mode.

I was actually thinking about kernels running from RAM (e.g. TFTP
boot or such).  The solution I'm talking about would also work
from flash, but as you say, most people are moving away from that.
There are still reasons to run XIP from flash, though: boot speed
is one.

miket
