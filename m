Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHFSk6>; Mon, 6 Aug 2001 14:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHFSks>; Mon, 6 Aug 2001 14:40:48 -0400
Received: from dhcp233054.columbus.rr.com ([204.210.233.54]:15891 "HELO
	neutral.verbum.org") by vger.kernel.org with SMTP
	id <S268922AbRHFSkk>; Mon, 6 Aug 2001 14:40:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <87elqs2wbx.church.of.emacs@space-ghost.verbum.org>
	<20010806022727.A25793@saw.sw.com.sg>
X-Attribution: Colin
X-Face: %'w-_>8Mj2_'=;I$myE#]G"'D>x3CY_rk,K06:mXFUvWy>;3I"BW3_-MAiUby{O(mn"wV@m
 dd`)Vk[27^^Sa<qRKA=qTu-uV/qLcGrMm-}A24N2wgr)5%_46(#WMTajfXc_DBt)&'/(J1
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.104
 (powerpc-debian-linux-gnu)
Organization: The Ohio State University Dept. of Computer and Info. Science
From: Colin Walters <walters@cis.ohio-state.edu>
Date: Mon, 06 Aug 2001 14:39:14 -0400
In-Reply-To: <20010806022727.A25793@saw.sw.com.sg> (Andrey Savochkin's
 message of "Mon, 6 Aug 2001 02:27:27 -0700")
Message-ID: <873d75janh.church.of.emacs@space-ghost.verbum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@saw.sw.com.sg> writes:

> Someone who experiences such timeouts needs to figure out how much
> time it really can take before a command is accepted.  Some time ago
> the timeout was increased by the factor of 10, and now the current
> timeout looks being insufficient.  It might be a problem with the
> time of specific commands or specific chip revisions.  Or some
> hardware is too clever and somehow optimizes those repeated read
> operations, so that they no longer take a fixed number of bus
> cycles.

Shouldn't a udelay(1) always take one microsecond, regardless of
hardware optimizations?

> In short, that patch isn't a real solution.  If someone provides me
> with the information which commands times-out and how much time they
> really need, we could have a real solution.

How can I help?  Instrument the code by hand with printk statements?
Or is there a better way?
