Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135926AbRAJPZs>; Wed, 10 Jan 2001 10:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135927AbRAJPZi>; Wed, 10 Jan 2001 10:25:38 -0500
Received: from ns.sysgo.de ([213.68.67.98]:41469 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S135926AbRAJPZ0>;
	Wed, 10 Jan 2001 10:25:26 -0500
Date: Wed, 10 Jan 2001 16:25:21 +0100 (MET)
From: Robert Kaiser <rob@sysgo.de>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <3A5BBF5A.7030103@megapathdsl.net>
Message-ID: <Pine.LNX.4.21.0101101618120.19662-100000@dagobert.svc.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Thanks very much for your suggestions!

On Tue, 9 Jan 2001, Miles Lane wrote:

> Just out of curiosity, did you use a 2.2 series
> .config file and then run make oldconfig or did
> you build a new .config file from scratch?

No, I built it from scratch with make xconfig.

> 
> I have periodically built kernels that crashed
> immediately at the point you mention.  Usually this
> was due to me choose configuration options that
> were incompatible with my machine's hardware.

You mean they crashed at the exact same statement ?
That would be an interesting hint, can you confirm it ?

> 
> Another time, the machine wouldn't boot because
> I needed a new version of LILO.  I also have seen
> at least one machine where I needed to specify
> "linear" as one of the options in lilo.conf.
> If you aren't specifying "linear" now, give it
> a try.

I am not using LILO (yet). I tried booting with SYSLINUX
or by dumping the kernel binary to floppy and booting from
it. Both showed the same result.

----------------------------------------------------------------
Robert Kaiser                          email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany    fax:   (49) 6136 9948-10


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
