Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA3HTq>; Tue, 30 Jan 2001 02:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRA3HTf>; Tue, 30 Jan 2001 02:19:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129101AbRA3HTW>; Tue, 30 Jan 2001 02:19:22 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: *massive* slowdowns on 2.4.1-pre1[1|2]
Date: 29 Jan 2001 23:17:58 -0800
Organization: Transmeta Corporation
Message-ID: <955pr6$afk$1@penguin.transmeta.com>
In-Reply-To: <3A761FEC.1C564FAE@the-rileys.net> <Pine.LNX.4.10.10101292102030.28124-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10101292102030.28124-100000@coffee.psychology.mcmaster.ca>,
Mark Hahn  <hahn@coffee.psychology.mcmaster.ca> wrote:
>> Kernel 2.4.1-pre11 and pre12 are both massively slower than 2.4.0 on the
>> same machine, compiled with the same options.  The machine is a Athlon
>> 900 on a KT133 chipset.  The slowdown is noticealbe in all areas...
>
>this is known: Linus decreed that, since two people reported 
>disk corruption on VIA, any machine with a VIA southbridge
>must boot in stupid 1992 mode (PIO).  (yes, it might be possible
>to boot with ide=autodma or something, but who would guess?)
>
>Linus: I hope you don't consider this a releasable state!
>VIA now owns 40% of the chipset market...

So find somebody who can figure out why the corruption happens, and I'll
be really happy with a patch that fixes it. In the meantime,
"releaseable" very much means that we did _everything_ possible to make
sure that people don't screw their disks over.

You have to realize that stability takes precedence over EVERYTHING. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
