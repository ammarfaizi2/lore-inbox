Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRBWQ0F>; Fri, 23 Feb 2001 11:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131018AbRBWQZz>; Fri, 23 Feb 2001 11:25:55 -0500
Received: from viper.haque.net ([64.0.249.226]:46728 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S131009AbRBWQZl>;
	Fri, 23 Feb 2001 11:25:41 -0500
Date: Fri, 23 Feb 2001 11:25:22 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: William Stearns <wstearns@pobox.com>
cc: Fabrizio Ammollo <f.ammollo@reitek.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mount -o loop of ISO image lockup
In-Reply-To: <Pine.LNX.4.30.0102231022250.2116-100000@sparrow.websense.net>
Message-ID: <Pine.LNX.4.32.0102231124050.29143-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't want to mention the patch because I was investigating my load
hovering around 1.3 after mounting an image using the patch. I know I
mentioned it to someone else before but I sent out the email before I
noticed the load.

On Fri, 23 Feb 2001, William Stearns wrote:

> Good morning, Mohammed, Fabrizio,
>
> On Fri, 23 Feb 2001, Mohammad A. Haque wrote:
>
> > Known problem.
>
> 	Then wouldn't it make sense to point Fabrizio at a known solution?
> ;-)
> 	Fabrizio: I'm going to guess that your problem might be the loop
> lockups that have been part of late 2.3 and all 2.4.  Jenbs Axboe has some
> patches that seem to fix the problem; see
> ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/
> 	The loop-6 patch there appears to apply to 2.4.2-ac1 and I
> suspect will apply to 2.4.2 proper.
> 	Mohammed: is there another problem or fix of which I'm not aware?
> 	Cheers,
> 	- Bill
>
> > Fabrizio Ammollo wrote:
> > >
> > > [1.] mount -o loop of ISO image lockup
> > > [2.] mount of an ISO image created with mkisofs and correctly read and
> > > verified by isoread and isovrfy locks ; nothing is reported my mount, and it
> > > is unkillable ; the line is reported by ps this way:
>
> ---------------------------------------------------------------------------
> 	"That vulnerability is completely theoretical."  -- Microsoft
> 	L0pht, Making the theoretical practical since 1992.
> (Courtesy of "Deliduka, Bennet" <bennet.deliduka@state.vt.us>)
> --------------------------------------------------------------------------
> William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
> and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
> LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
> --------------------------------------------------------------------------
>
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

