Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282236AbRLWKUG>; Sun, 23 Dec 2001 05:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286862AbRLWKT4>; Sun, 23 Dec 2001 05:19:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59653 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286861AbRLWKTq>; Sun, 23 Dec 2001 05:19:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: AMD SC410 boot problems with recent kernels
Date: 23 Dec 2001 02:19:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a04b3k$7sr$1@cesium.transmeta.com>
In-Reply-To: <a03cuj$661$1@cesium.transmeta.com> <Pine.LNX.4.33.0112231009500.10528-100000@callisto.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0112231009500.10528-100000@callisto.local>
By author:    Robert Schwebel <robert@schwebel.de>
In newsgroup: linux.dev.kernel
> 
> Could you elaborate why you think that the old code worked only by
> accident? [please be patient - I'm no native speaker and it may be that I
> do sometimes not understand everything correctly. I'm trying hard.] As I
> said above: before I do not understand _why_ the new code breaks it's
> rather difficult to draw conclusions.
> 
> If the board is really _broken_ I have no problem with the fact that in
> the future the manufacturer has either to supply a correct BIOS or a
> workaround patch has to be used. If it's only uggly that there's no BIOS
> routine it would IMHO be better to find a way to make it work again. There
> are fixes for other uggly architectures in the code as well, see the
> Toshiba Laptop reference. If the board may be PC compatible, Linux should
> IMHO boot without further changes.
> 

The weird part about your board is that the code clearly *works*, or
your kernel wouldn't boot at all.  It somehow poisons the system,
though, and that's utterly bizarre.

I don't think this is debuggable without access to hardware (and maybe
not even then.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
