Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265041AbSJPPEI>; Wed, 16 Oct 2002 11:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbSJPPEI>; Wed, 16 Oct 2002 11:04:08 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55714 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265041AbSJPPEH>; Wed, 16 Oct 2002 11:04:07 -0400
Date: Wed, 16 Oct 2002 10:09:57 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roger While <RogerWhile@sim-basis.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 make modules fail
In-Reply-To: <4.3.2.7.2.20021016120554.00c5f2e0@192.168.6.2>
Message-ID: <Pine.LNX.4.44.0210161007210.1904-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Roger While wrote:

>    gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
> -DMODULE   -DKBUILD_BASENAME=isdn_ppp   -c -o drivers/isdn/i4l/isdn_ppp.o 
> drivers/isdn/i4l/isdn_ppp.c
> drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_free':
> drivers/isdn/i4l/isdn_ppp.c:114: warning: implicit declaration of function 
> `save_flags'

ISDN multilink PPP is currently badly broken, as you noticed you won't 
even get it to compile. With CONFIG_ISDN_MPP off, things look much better 
in my tree already.

After I submitted my next ISDN update, testing PPP-over-ISDN would be 
welcome ;)

--Kai



