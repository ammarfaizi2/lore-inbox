Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132013AbRA3CGy>; Mon, 29 Jan 2001 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131534AbRA3CGp>; Mon, 29 Jan 2001 21:06:45 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:62796 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132013AbRA3CG1>; Mon, 29 Jan 2001 21:06:27 -0500
Date: Mon, 29 Jan 2001 21:05:53 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: David Riley <oscar@the-rileys.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: *massive* slowdowns on 2.4.1-pre1[1|2]
In-Reply-To: <3A761FEC.1C564FAE@the-rileys.net>
Message-ID: <Pine.LNX.4.10.10101292102030.28124-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel 2.4.1-pre11 and pre12 are both massively slower than 2.4.0 on the
> same machine, compiled with the same options.  The machine is a Athlon
> 900 on a KT133 chipset.  The slowdown is noticealbe in all areas...

this is known: Linus decreed that, since two people reported 
disk corruption on VIA, any machine with a VIA southbridge
must boot in stupid 1992 mode (PIO).  (yes, it might be possible
to boot with ide=autodma or something, but who would guess?)

Linus: I hope you don't consider this a releasable state!
VIA now owns 40% of the chipset market...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
