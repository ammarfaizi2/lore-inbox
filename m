Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbRAaXVM>; Wed, 31 Jan 2001 18:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129770AbRAaXVD>; Wed, 31 Jan 2001 18:21:03 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:12744 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129753AbRAaXUY>; Wed, 31 Jan 2001 18:20:24 -0500
Date: Wed, 31 Jan 2001 23:18:33 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Grzegorz Sojka <grzes@prioris.mini.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG
In-Reply-To: <Pine.BSF.4.21.0101312339170.38659-100000@prioris.mini.pw.edu.pl>
Message-ID: <Pine.SOL.4.21.0101312317340.24868-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Grzegorz Sojka wrote:

> I am using kernel v2.4.0 on Abit BP6 with two Intel Pentium Celeron
> 366@517Mhz + video based on Riva TNT2 M64 32Mb + network card 3com 3c905b
> + Creative Sound Blaster 64 pnp isa and hercules video card. I'm geting
> all over the time messages like that:
> Jan 31 23:37:16 Zeus kernel: APIC error on CPU0: 02(02)
> Jan 31 23:37:17 Zeus kernel: APIC error on CPU1: 02(08)
> Jan 31 23:37:26 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:37:26 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:37:26 Zeus kernel: APIC error on CPU0: 02(04)
> Jan 31 23:37:27 Zeus kernel: APIC error on CPU0: 04(02)
> Jan 31 23:37:30 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:38:17 Zeus kernel: APIC error on CPU0: 02(08)
> Jan 31 23:38:20 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:38:22 Zeus kernel: APIC error on CPU0: 08(02)
> Jan 31 23:38:26 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:38:26 Zeus kernel: APIC error on CPU0: 02(02)
> Jan 31 23:38:29 Zeus kernel: APIC error on CPU1: 08(02)
> Jan 31 23:38:41 Zeus kernel: APIC error on CPU1: 02(08)
> Jan 31 23:38:51 Zeus kernel: APIC error on CPU0: 02(02)
> Jan 31 23:38:58 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:39:15 Zeus kernel: APIC error on CPU1: 08(02)
> Jan 31 23:39:15 Zeus kernel: APIC error on CPU1: 02(08)
> Jan 31 23:39:15 Zeus kernel: APIC error on CPU0: 02(04)
> Jan 31 23:39:17 Zeus kernel: APIC error on CPU1: 08(08)
> Jan 31 23:39:18 Zeus kernel: APIC error on CPU1: 08(02)
> Jan 31 23:39:46 Zeus kernel: APIC error on CPU0: 04(02)
> And when I was using kernels v2.2.x ther was no such messages. I am
> wandering if it is hardware or software problem?

Hardware problem. You don't SEE these messages on 2.2 because it doesn't
tell you about them :-)

(These are common, but fairly harmless FWIH, on BP6s.)


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
