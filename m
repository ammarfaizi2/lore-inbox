Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287731AbSASWqm>; Sat, 19 Jan 2002 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287770AbSASWqX>; Sat, 19 Jan 2002 17:46:23 -0500
Received: from cj723460-a.alex1.va.home.com ([24.23.56.237]:49032 "EHLO
	CJ723460-A.alex1.va.home.com") by vger.kernel.org with ESMTP
	id <S287731AbSASWqU>; Sat, 19 Jan 2002 17:46:20 -0500
Date: Sat, 19 Jan 2002 17:45:24 -0500
From: "G . Sumner Hayes" <sumner-kernel@forceovermass.com>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-audio-dev@music.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, patches and latencies
Message-ID: <20020119174524.A1387@forceovermass.com>
In-Reply-To: <3C41849D.72ECBC05@kolumbus.fi> <3C41AC11.4060806@drugphish.ch> <3C41BFF1.6FF714A1@kolumbus.fi> <3C496A67.5237873F@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C496A67.5237873F@kolumbus.fi>; from jussi.laako@kolumbus.fi on Sat, Jan 19, 2002 at 02:45:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 02:45:27PM +0200, Jussi Laako wrote:
> I made a web page for my kernel patch combinations. Aimed primarily for low
> latency use.
> 
> http://www.pp.song.fi/~visitor/linux/
> 
> Latest 2.4.17-jl11 contains:
> 
>  - Andre's ide driver update
>  - Lionel's SiS ide driver update
>  - ALi ide fix
>  - Small AGP fix
>  - Updated VIA KT133/KT266 fix
>  - Rik's rmap-11c
>  - Ingo's sched-O1-J2
[SNIP]
> -jl11-ll also contains:
> 
>  - full lowlatency patch
>  - my DRM lowlatency patch

FWIW, I just built this and did a kernel compile+updatedb+xmms
test.  Normally (Red Hat's  2.4.7), xmms skips like mad under those
circumstances, with this patch it didn't skip at all.  And system "feel"
is good.

Not scientific numbers, and maybe not all that useful given the
huge number of variables in the patch, but I figured I'd throw it
out here.

Thanks for putting this patch up, Jussi.

  Sumner
