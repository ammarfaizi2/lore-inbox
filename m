Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRKEICX>; Mon, 5 Nov 2001 03:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280328AbRKEICN>; Mon, 5 Nov 2001 03:02:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23827 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280327AbRKEICG>; Mon, 5 Nov 2001 03:02:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Special Kernel Modification Results
Date: 5 Nov 2001 00:01:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s5h1b$fih$1@cesium.transmeta.com>
In-Reply-To: <1004926188.3be5f4ec7e622@mail.outstep.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1004926188.3be5f4ec7e622@mail.outstep.com>
By author:    lonnie@outstep.com
In newsgroup: linux.dev.kernel
> 
> It is nice that in Linux a person can easily set permissions to
> prevent someone from entering a particular directory, but for the
> special projects when you want to somehow confine them to their HOME
> directory then the standard permissions are somewhat illsuited for
> the task.
> 
> There is always the problem of being able to see the binaries from
> the users directories if you were to lock them in.
> 
> In any case, I am thinking that a combination of chroot and
> hard-links might do the trick.
> 

Either that, or chroot and vfsbinds (mount --bind), which might
actually serve you better (no one-filesystem limit.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
