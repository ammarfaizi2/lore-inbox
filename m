Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbQKHD5u>; Tue, 7 Nov 2000 22:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQKHD5k>; Tue, 7 Nov 2000 22:57:40 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:42682 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129544AbQKHD5d>; Tue, 7 Nov 2000 22:57:33 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 03:57:10 +0000 (GMT)
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <20001107214147.B8542@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011080351110.8632-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> Your way out in the weeds.  What started this thread was a customer who
> ended up loading the wrong arch on a system and hanging.  I have to
> post a kernel RPM for our release, and it's onerous to make customers
> recompile kernels all the time and be guinea pigs for arch ports.  
> They just want it to boot, and run with the same level of ease of use
> and stability they get with NT and NetWare and other stuff they are used
> to.   This is an easy choice from where I'm sitting.

So you're complaining that as a vendor you have to ship multiple kernels?
The point remains the same.

The only time I recall recently where a kernel hasn't booted was when the
AMD Athlon appeared, and the MTRR code needed fixing.
There wasn't a lot anyone could have done, without seeing documentation
(which iirc wasn't available at the time).
The reason NT & Netware probably loaded fine is that they don't set
the MTRRs themselves, but rely on third party utilities to do this
for them after they've booted.

All other recent cases of non booting that I've seen have been a
case of user error miscompiling for a wrong target.
As a vendor, you don't worry about this as you ship binary kernels,
and $enduser never needs to see a source tree.

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
