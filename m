Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRLWUDY>; Sun, 23 Dec 2001 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284141AbRLWUDO>; Sun, 23 Dec 2001 15:03:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27142 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284140AbRLWUDG>; Sun, 23 Dec 2001 15:03:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: AMD SC410 boot problems with recent kernels
Date: 23 Dec 2001 12:02:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a05d93$a37$1@cesium.transmeta.com>
In-Reply-To: <a03cuj$661$1@cesium.transmeta.com> <Pine.LNX.4.33.0112231009500.10528-100000@callisto.local> <20011223131658.3944A36FA8@hog.ctrl-c.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011223131658.3944A36FA8@hog.ctrl-c.liu.se>
By author:    wingel@hog.ctrl-c.liu.se (Christer Weinigel)
In newsgroup: linux.dev.kernel
> 
> It is an embedded board with a _mostly_ PC compatible CPU, but it
> has a few strange bugs/features that have to be worked around. For
> example look a the fix for the timer and serial port in:
> 
>     http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0667.html
> 
> Especially the serial fix is (IMHO) too ugly to live in the standard
> kernel.
> 

#ifdef CONFIG_SC410 time?

> My belief is that the SC410 based boards are so strange that one has
> to have a custom kernel anyways, so asking why it isn't 100% PC
> compatible and trying to fix that is rather pointless.

Thanks for confirming my suspicion.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
