Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQKOVmx>; Wed, 15 Nov 2000 16:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQKOVmm>; Wed, 15 Nov 2000 16:42:42 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:55710 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129492AbQKOVmg>; Wed, 15 Nov 2000 16:42:36 -0500
From: davej@suse.de
Date: Wed, 15 Nov 2000 21:12:13 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: hpa@zytor.com
Subject: Re: test11-pre5, Athlon, and Machine Check Architecture
Message-ID: <Pine.LNX.4.21.0011152107420.2791-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, since at least AMD Athlon actually advertises MCA, I would
> like to verify that the code works on these processors before
> submitting it to Linus.

The Athlon MCA is basically the same architecture-wise as Pentium Pro/II
But there are some differences..  Until AMD make document 21656 (BIOS
writers guide) public (or even a subset of it), we'll not be able to take
advantage of these extra features.

I'd suggest that until this happens, we leave bluesmoke.c Intel only.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
