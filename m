Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136347AbRDWCoN>; Sun, 22 Apr 2001 22:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136349AbRDWCoB>; Sun, 22 Apr 2001 22:44:01 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:4480
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S136347AbRDWCnf>; Sun, 22 Apr 2001 22:43:35 -0400
Date: Sun, 22 Apr 2001 19:42:49 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: manuel@mclure.org,
        Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
In-Reply-To: <20010422192520.A3618@ulthar.internal.mclure.org>
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org> <200104222138.XAA00666@kufel.dom> <200104222138.XAA00666@kufel.dom> <20010422192520.A3618@ulthar.internal.mclure.org>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Manuel A. McLure wrote:

> Did you try nesting more than one "su -"? The first one after a boot
> works for me - every other one fails.

Same here: the first "su -" works OK, but a second nested one hangs:

 8825 pts/2    S      0:00 /bin/su -
 8826 pts/2    S      0:00 -bash
 8854 pts/2    T      0:00 stty erase ?
 8855 pts/0    R      0:00 ps ax

"kill -CONT 8854" has no effect.  

> I'm on RH71 - this may be specific to this release. It's also
> kernel-dependent, I can reboot with ac5 and the problem does not
> happen.  The kernel is compiled with the same compiler as yours.

I'm RH-7.1 and kernel 2.4.4-pre6 (with the via 3.23 driver from -ac)

Cheers, Wayne
