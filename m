Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289770AbSAJXJk>; Thu, 10 Jan 2002 18:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAJXJd>; Thu, 10 Jan 2002 18:09:33 -0500
Received: from CPE-203-51-31-178.nsw.bigpond.net.au ([203.51.31.178]:11760
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S289770AbSAJXJZ>; Thu, 10 Jan 2002 18:09:25 -0500
Message-ID: <3C3E1F1D.8B11A126@eyal.emu.id.au>
Date: Fri, 11 Jan 2002 10:09:17 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> So here it goes pre3.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=orinoco  -DEXPORT_SYMTAB -c orinoco.c
orinoco.c:291: hermes_rid.h: No such file or directory
orinoco.c:293: ieee802_11.h: No such file or directory
.....
make[3]: *** [orinoco.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net/wireless'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
