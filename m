Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSC1RNL>; Thu, 28 Mar 2002 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313158AbSC1RNB>; Thu, 28 Mar 2002 12:13:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63247 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313131AbSC1RMt>; Thu, 28 Mar 2002 12:12:49 -0500
Date: Thu, 28 Mar 2002 12:10:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj2
In-Reply-To: <20020328124548.D23328@suse.de>
Message-ID: <Pine.LNX.3.96.1020328120309.18285D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Dave Jones wrote:

> On Wed, Mar 27, 2002 at 09:35:46PM -0500, Nathan Walp wrote:
>  > Compile error in 2.5.7-dj2, 2.5.7-dj1 compiled fine, has been running 7
>  > days now.  
>  > 
>  > make[4]: Entering directory `/usr/src/linux-2.5.7-dj2/drivers/scsi/aic7xxx'
>  > gcc -D__KERNEL__ -I/usr/src/linux-2.5.7-dj2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
>  > aic7xxx_osm.c: In function `ahc_linux_setup_tag_info':
>  > aic7xxx_osm.c:1036: warning: implicit declaration of function `strtok'
>  > aic7xxx_osm.c:1036: warning: assignment makes pointer from integer without a cast
> 
> Ok, thanks. I'll take a look at that later, even if it means reverting
> to the -dj1 version of aic

  I haven't d/l this version (and I'm generally not even trying 2.5 at the
moment), but I would bet the include which defines strtok got zapped or
moved.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

