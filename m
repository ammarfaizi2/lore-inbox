Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRBWPaK>; Fri, 23 Feb 2001 10:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRBWPaB>; Fri, 23 Feb 2001 10:30:01 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:63878 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129624AbRBWP3n>; Fri, 23 Feb 2001 10:29:43 -0500
Date: Fri, 23 Feb 2001 10:28:18 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Fabrizio Ammollo <f.ammollo@reitek.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        William Stearns <wstearns@pobox.com>
Subject: Re: PROBLEM: mount -o loop of ISO image lockup
In-Reply-To: <3A9668D0.22DACB3F@haque.net>
Message-ID: <Pine.LNX.4.30.0102231022250.2116-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, Mohammed, Fabrizio,

On Fri, 23 Feb 2001, Mohammad A. Haque wrote:

> Known problem.

	Then wouldn't it make sense to point Fabrizio at a known solution?
;-)
	Fabrizio: I'm going to guess that your problem might be the loop
lockups that have been part of late 2.3 and all 2.4.  Jenbs Axboe has some
patches that seem to fix the problem; see
ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/
	The loop-6 patch there appears to apply to 2.4.2-ac1 and I
suspect will apply to 2.4.2 proper.
	Mohammed: is there another problem or fix of which I'm not aware?
	Cheers,
	- Bill

> Fabrizio Ammollo wrote:
> >
> > [1.] mount -o loop of ISO image lockup
> > [2.] mount of an ISO image created with mkisofs and correctly read and
> > verified by isoread and isovrfy locks ; nothing is reported my mount, and it
> > is unkillable ; the line is reported by ps this way:

---------------------------------------------------------------------------
	"That vulnerability is completely theoretical."  -- Microsoft
	L0pht, Making the theoretical practical since 1992.
(Courtesy of "Deliduka, Bennet" <bennet.deliduka@state.vt.us>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------


