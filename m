Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDCJa>; Fri, 3 Nov 2000 21:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQKDCJU>; Fri, 3 Nov 2000 21:09:20 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:16106 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129033AbQKDCJB>; Fri, 3 Nov 2000 21:09:01 -0500
From: davej@suse.de
Date: Sat, 4 Nov 2000 02:07:46 +0000 (GMT)
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
In-Reply-To: <3A037A2B.41D6AAA@didntduck.org>
Message-ID: <Pine.LNX.4.21.0011040204270.10466-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Brian Gerst wrote:

> > That bug fix is for the earlier Cyrix 6x86 if I'm not mistaken.
> > The MII is a different monster.
> According to the docs on VIA's site, the MII's cpuid can still be turned
> off, but it is on by default at reset.  I wouldn't trust the BIOS to not
> screw it up.

Err, what? If it's on by default...
A old BIOS that doesn't know about it won't switch it off.
A BIOS that does know about it will leave it (or maybe offer an option to
 disable it)

If neither of the above are true (Ie, a BIOS bug) and it's switched off
by the time Linux boots, I think we'd have heard about it by now, as MII
users would notice a lack of features.

regards,

Dave.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
