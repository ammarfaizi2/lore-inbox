Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKPWtM>; Thu, 16 Nov 2000 17:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKPWtC>; Thu, 16 Nov 2000 17:49:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44299 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129150AbQKPWsy>; Thu, 16 Nov 2000 17:48:54 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: Local root exploit with kmod and modutils > 2.1.121
Date: 16 Nov 2000 14:18:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v1mfq$oi3$1@cesium.transmeta.com>
In-Reply-To: <20001116222152.E8326@nomade> <5529.974412016@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5529.974412016@ocs3.ocs-net>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> On Thu, 16 Nov 2000 22:21:52 +0100, 
> Xavier Bestel <xavier.bestel@free.fr> wrote:
> >as modprobe (insmod) args parsing seems POSIX compliant, we should put a
> >"--" before
> >what should be interpreted only as a textual argument, not as an option.
> >This is a lot safer: whatever is passed, modprobe will take it as a module
> >name.
> 
> That only solves one of the two exploit methods.  modutils 2.3.20
> solves both without any kernel changes, mainly so it fixes the problem
> on all kernels, including 2.2.
> 

However, the kernel change is probably still a good idea.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
