Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136362AbRDWDWe>; Sun, 22 Apr 2001 23:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136363AbRDWDWP>; Sun, 22 Apr 2001 23:22:15 -0400
Received: from leng.mclure.org ([64.81.48.142]:7176 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136362AbRDWDWB>; Sun, 22 Apr 2001 23:22:01 -0400
Date: Sun, 22 Apr 2001 20:21:58 -0700
From: Manuel McLure <manuel@mclure.org>
To: whitney@math.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
Message-ID: <20010422202158.E970@ulthar.internal.mclure.org>
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org> <200104222138.XAA00666@kufel.dom> <200104222138.XAA00666@kufel.dom> <20010422192520.A3618@ulthar.internal.mclure.org> <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net>; from whitney@math.berkeley.edu on Sun, Apr 22, 2001 at 19:42:49 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 19:42 Wayne Whitney wrote:
> In mailing-lists.linux-kernel, Manuel A. McLure wrote:
> 
> > Did you try nesting more than one "su -"? The first one after a boot
> > works for me - every other one fails.
> 
> Same here: the first "su -" works OK, but a second nested one hangs:
> 
>  8825 pts/2    S      0:00 /bin/su -
>  8826 pts/2    S      0:00 -bash
>  8854 pts/2    T      0:00 stty erase ?
>  8855 pts/0    R      0:00 ps ax
> 
> "kill -CONT 8854" has no effect.  
> 
> > I'm on RH71 - this may be specific to this release. It's also
> > kernel-dependent, I can reboot with ac5 and the problem does not
> > happen.  The kernel is compiled with the same compiler as yours.
> 
> I'm RH-7.1 and kernel 2.4.4-pre6 (with the via 3.23 driver from -ac)

It looks like this may very well be a RH 7.1 interaction with the kernel,
since others are not seeing this.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

