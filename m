Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292871AbSB0TPT>; Wed, 27 Feb 2002 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292904AbSB0TOw>; Wed, 27 Feb 2002 14:14:52 -0500
Received: from www.transvirtual.com ([206.14.214.140]:3854 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292839AbSB0TNA>; Wed, 27 Feb 2002 14:13:00 -0500
Date: Wed, 27 Feb 2002 11:12:54 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: compiling Linux 2.5.5-dj2 + console_8.diff
In-Reply-To: <3C7D2E2A.8000905@st-peter.stw.uni-erlangen.de>
Message-ID: <Pine.LNX.4.10.10202271112130.3958-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BUILD_BASENAME=dummycon  -c -o dummycon.o dummycon.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.5-xfs-dj2/include  -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
> -DKBUILD_BASENAME=vgacon  -c -o vgacon.o vgacon.c
> vgacon.c: In function `vgacon_do_font_op':
> vgacon.c:816: structure has no member named `vc_sw'
> make[3]: *** [vgacon.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.5-xfs-dj2/drivers/video'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.5-xfs-dj2/drivers/video

Sorry. I posted a incomplete patch that I haven't finished yet. I'm
working on it.


