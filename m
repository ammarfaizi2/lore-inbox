Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272057AbRIDR5F>; Tue, 4 Sep 2001 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272056AbRIDR4z>; Tue, 4 Sep 2001 13:56:55 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:55943 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S272045AbRIDR4e>; Tue, 4 Sep 2001 13:56:34 -0400
Message-ID: <3B9515CC.820C1F20@pp.inet.fi>
Date: Tue, 04 Sep 2001 20:56:28 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v1.4d file/swap crypto package
In-Reply-To: <3B93B32A.69D25916@pp.inet.fi> <3B93EE69.5674035F@eyal.emu.id.au> <3B940291.C752F45B@pp.inet.fi> <3B94C8A9.EA7D4E72@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:
> Problem is that one gets tons of errors due to the use of the wrong
> kernel.
> The exact way for doing it right is actually:
>         depmod -ae $(KERNELRELEASE) -F $(LS)/System.map

Yep, but one must define KERNELRELEASE for 2.0 kernels. As I said, I will
fix this for next release.

> > Loop-AES build instructions _require_ you to disable the loop driver in the
> > kernel. If you have two loop.o drivers, you skipped some build instructions.
> 
> It is not in the kernel, it is in my /lib/modules as it was built
> originally.
> I want to keep it there while I play with the new module, and not lose
> the
> original. Naturally, just my preference, not everybodies.

I meant that loop must be completely disabled, as it says in the README:

CONFIG_BLK_DEV_LOOP=n

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

