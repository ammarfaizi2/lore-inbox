Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSFCTbL>; Mon, 3 Jun 2002 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFCTbL>; Mon, 3 Jun 2002 15:31:11 -0400
Received: from pD952AF1C.dip.t-dialin.net ([217.82.175.28]:43397 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S312558AbSFCTbJ>; Mon, 3 Jun 2002 15:31:09 -0400
Date: Mon, 3 Jun 2002 13:31:00 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thomas Duffy <tduffy@directvinternet.com>
cc: Keith Owens <kaos@ocs.com.au>,
        Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, release 3.0 is
 available
In-Reply-To: <1023132138.25501.6.camel@tduffy-lnx.afara.com>
Message-ID: <Pine.LNX.4.44.0206031330070.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3 Jun 2002, Thomas Duffy wrote:
> I get this error now on sparc64:
> 
> tduffy@curie:/build2/tduffy/linux_kbuild$ make -f Makefile-2.5 oldconfig
> Using ARCH='sparc64' AS='as' LD='ld' CC='sparc64-linux-gcc' CPP='sparc64-linux-gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
> Generating global Makefile
>   phase 1 (find all inputs)
> make: *** [phase1] Error 139
> 
> tduffy@curie:/build2/tduffy/linux_kbuild$ make -f Makefile-2.5 oldconfig
> Using ARCH='sparc64' AS='as' LD='ld' CC='sparc64-linux-gcc' CPP='sparc64-linux-gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
> Generating global Makefile
>   phase 1 (find all inputs)
> pp_makefile1: Attempt to fetch invalid key s(0x73)-9473
> make: *** [phase1] Error 134
> 
> more verbose (PP_MAKEFILE1_FLAGS=-v) output:
> 
> ...
> Generating global Makefile
>   phase 1 (find all inputs)
> pp_makefile1 verbose 1
>     scan_trees   0 /build2/tduffy/linux_kbuild/
> make: *** [phase1] Error 139
> 
> 
> -tduffy

Did you apply the sparc64 patch? Yet it's there.

You might even try the upcoming -ct1

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

