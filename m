Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRDAKLO>; Sun, 1 Apr 2001 06:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbRDAKKz>; Sun, 1 Apr 2001 06:10:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:43429 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S132126AbRDAKKf>;
	Sun, 1 Apr 2001 06:10:35 -0400
Date: Sun, 1 Apr 2001 12:09:18 +0200
From: David Weinehall <tao@acc.umu.se>
To: Simon Garner <sgarner@expio.co.nz>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Message-ID: <20010401120918.B23618@khan.acc.umu.se>
In-Reply-To: <00d501c0ba93$1e6331b0$1400a8c0@expio.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <00d501c0ba93$1e6331b0$1400a8c0@expio.net.nz>; from sgarner@expio.co.nz on Sun, Apr 01, 2001 at 10:04:17PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 10:04:17PM +1200, Simon Garner wrote:
> From: "Mikael Pettersson" <mikpe@csd.uu.se>
> 
> > Boot with "nmi_watchdog=0" as a boot parameter. Does it work now?
> > 
> > Some people have reported before here that the IO-APIC driven NMI
> > watchdog itself can cause boot-time hangs.
> > 
> > /Mikael
> 
> 
> Thanks, but I do not have watchdog support compiled into the kernel.

Doesn't matter. The NMI-watchdog tries to detect SMP-lockups, and is
always present. Unless you specifically disable it on boot.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
