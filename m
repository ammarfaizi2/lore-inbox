Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289186AbSBDWJo>; Mon, 4 Feb 2002 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289193AbSBDWJf>; Mon, 4 Feb 2002 17:09:35 -0500
Received: from CPE-203-51-26-28.nsw.bigpond.net.au ([203.51.26.28]:15612 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S289186AbSBDWJT>; Mon, 4 Feb 2002 17:09:19 -0500
Message-ID: <3C5F0689.CAD1A09F@eyal.emu.id.au>
Date: Tue, 05 Feb 2002 09:09:13 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre7-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.18-pre8: missing file
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> No more big patches for 2.4.18, please... We are getting close to the -rc
> stage.
> 
> pre8:
> - VXFS update                                   (Christoph Hellwig)

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=vxfs_bmap  -c -o vxfs_bmap.o vxfs_bmap.c
In file included from vxfs_bmap.c:38:
vxfs.h:42: vxfs_kcompat.h: No such file or directory
make[2]: *** [vxfs_bmap.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/fs/freevxfs'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
