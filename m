Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTIUVIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTIUVIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:08:18 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26294 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262569AbTIUVIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:08:17 -0400
Date: Sun, 21 Sep 2003 17:07:58 -0400 (EDT)
From: Matt Hahnfeld <matth@everysoft.com>
X-X-Sender: hahnfld@sotec
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: SLOW machine when HIGHMEM enabled (1gb memory, kernel 2.4.22)
In-Reply-To: <16238.2932.99763.591328@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0309211657470.12232-100000@sotec>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael --

Thanks for the help!

I have posted my /proc/mtrr and /proc/meminfo to
http://www.layover.com/matt/kernel/ .

The "lowmem" ones are when HIGHMEM was disabled, the "highmem" ones are
2.4.22 with CONF_HIGHMEM4G.  /proc/mtrr looks exatly the same whether or
not highmem is enabled.

I have the newest stable bios from Asus as of yesterday.

What should I see if the high memory isn't cachable?

On Sun, 21 Sep 2003, Mikael Pettersson wrote:

> Matt Hahnfeld writes:
>  > I have an ASUS P4P800-VM motherboard with 2 sticks of 512mb PC3200 and
>  > a single 2.4 ghz P4 processor.  The kernel is vanilla 2.4.22 configured
>  > for SMP (hyperthreading).
>  >
>  > When I use a kernel with high memory support off, I get good
>  > performance (despite not being able to use some of my memory).  When I
>  > enable CONFIG_HIGHMEM4G the remaining memory is detected, but the
>  > machine takes a big performance hit and starts running very slow --
>  > ie. kernel compilation looks like it would take 5 days instead of 5
>  > minutes.  /proc/meminfo doesn't look particularly strange and no
>  > strange log messages show up -- everything just runs slow...
>  >
>  > CONFIG_HIGHMEM64G produces the same results...
>  >
>  > Any suggestions?
>
> Sounds like maybe the high RAM isn't cacheable.
> What does /proc/mtrr and dmesg look like?
>
> Have you verified that you're running the latest BIOS?
>


