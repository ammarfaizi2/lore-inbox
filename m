Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129485AbQKVXGl>; Wed, 22 Nov 2000 18:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131919AbQKVXGV>; Wed, 22 Nov 2000 18:06:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10253 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129485AbQKVXGK>; Wed, 22 Nov 2000 18:06:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: include conventions /usr/include/linux/sys ?
Date: 22 Nov 2000 14:35:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vhhnv$j0d$1@cesium.transmeta.com>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com>
By author:    "LA Walsh" <law@sgi.com>
In newsgroup: linux.dev.kernel
>
> Linus has mentioned a desire to move kernel internal interfaces into
> a separate kernel include directory.  In creating some code, I'm wondering
> what the name of this should/will be.  Does it follow that convention
> would point toward a linux/sys directory?
> 

I suggested include/kernel and include/arch with include/linux and
include/asm being reserved for the kernel interfaces (ioctl and their
structures mostly.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
