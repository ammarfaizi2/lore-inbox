Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKJOix>; Sat, 10 Nov 2001 09:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKJOin>; Sat, 10 Nov 2001 09:38:43 -0500
Received: from d-dialin-1115.addcom.de ([62.96.163.163]:18670 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280669AbRKJOi1>; Sat, 10 Nov 2001 09:38:27 -0500
Date: Sat, 10 Nov 2001 15:38:27 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: <pinguin@wanadoo.nl>
cc: <linux-kernel@vger.kernel.org>, <isdn4linux@listserv.isdn4linux.de>
Subject: Re: modprobe hangs on isdn (2.4.10 and 1.4.13)
In-Reply-To: <200111092318.fA9NIc619331@t-rex.pinguins.dyn.dhs.org>
Message-ID: <Pine.LNX.4.33.0111101533480.3310-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[please continue this on the isdn4linx list, remove the CC to l-k]

On Sat, 10 Nov 2001 arjen@pinguins.dyn.dhs.org wrote:

> after a period of instability due to SMP and a
> 3Com ethernet card I upgraded to 2.4.10. But
> now the system consistantly hangs on boot
> during the modprobe of the hisax/isdn module.
> Hanging means total lockup of the system (no
> dump, nothing).

When exactly does the hang happen?
Can you try
modprobe isdn
modprobe hisax type=27 [or any wrong type]
modprobe hisax type=21 [or whichever card type is right for you]

I suppose the hang happens during the last modprobe, right?

Which was the last kernel version which worked for you?

--Kai

