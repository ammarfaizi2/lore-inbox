Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136353AbRDWDCC>; Sun, 22 Apr 2001 23:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136355AbRDWDBw>; Sun, 22 Apr 2001 23:01:52 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:42508 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S136353AbRDWDBk>; Sun, 22 Apr 2001 23:01:40 -0400
Message-ID: <3AE39B0D.9BA4413F@damncats.org>
Date: Sun, 22 Apr 2001 23:01:33 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manuel McLure <manuel@mclure.org>
CC: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org> <200104222138.XAA00666@kufel.dom> <20010422192520.A3618@ulthar.internal.mclure.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel McLure wrote:
> Did you try nesting more than one "su -"? The first one after a boot works
> for me - every other one fails.

I tried it with about a half-dozen nested and no problem. Mandrake
cooker here...

uname -a
Linux lion 2.4.3-ac11 #5 SMP Fri Apr 20 22:10:41 EDT 2001 i686 unknown

gcc --version 
2.96

ls -l /lib/libc-*
-rwxr-xr-x    1 root     root      1216268 Feb 21 05:38
/lib/libc-2.2.2.so

su --version
su (GNU sh-utils) 2.0

I don't think libc is the problem, unless it is in conjunction with the
compiler choice. Have you tried building the kernel with the updated Red
Hat gcc version? I know Mandrake has kept theirs current to Red Hat and
it works fine for me.

John
