Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269269AbTCBSrG>; Sun, 2 Mar 2003 13:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269273AbTCBSrG>; Sun, 2 Mar 2003 13:47:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55219 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269269AbTCBSrF>; Sun, 2 Mar 2003 13:47:05 -0500
Date: Sun, 02 Mar 2003 10:54:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [Bug 423] New: make -j X bzImage gives a warning
Message-ID: <48930000.1046631252@[10.10.2.4]>
In-Reply-To: <20030302183857.GA8094@mars.ravnborg.org>
References: <347860000.1046465385@flay> <20030228212504.GA21843@mars.ravnborg.org> <362820000.1046468331@flay> <20030302183857.GA8094@mars.ravnborg.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Sunday, March 02, 2003 19:38:57 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Feb 28, 2003 at 01:38:51PM -0800, Martin J. Bligh wrote:
>> > On Fri, Feb 28, 2003 at 12:49:45PM -0800, Martin J. Bligh wrote:
>> >> http://bugme.osdl.org/show_bug.cgi?id=423
>> >> 
>> >>            Summary: make -j X bzImage gives a warning
>> >>     Kernel Version: 2.5.63
>> >>             Status: NEW
>> >>           Severity: low	
>> >>              Owner: zippel@linux-m68k.org
>> >> make -j X bzImage gives a warning:
>> >> 
>> >> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make
>> >> rule.
>> >> 
>> >> Can we get rid of this one way or the other?
> 
> Kai has fixed this one in bk-latest.
> 
> Sample run:
> 
> [sam@mars kbuild4]$ make -j2 bzImage
> make[1]: `scripts/kconfig/conf' is up to date.
> ./scripts/kconfig/conf -s arch/i386/Kconfig
># 
># using defaults found in .config
># 
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
>   GEN     include/linux/compile.h (unchanged)
> Kernel: arch/i386/boot/bzImage is ready

Heh - very cool. Tested it out. Thanks Kai ...
I'll close that bug.

M.

