Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263659AbREYIs7>; Fri, 25 May 2001 04:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbREYIst>; Fri, 25 May 2001 04:48:49 -0400
Received: from qn-212-127-144-62.quicknet.nl ([212.127.144.62]:261 "HELO
	smcc.demon.nl") by vger.kernel.org with SMTP id <S263659AbREYIsb>;
	Fri, 25 May 2001 04:48:31 -0400
Message-ID: <XFMail.010525104812.nemosoft@smcc.demon.nl>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010525085024.A17867@alpha.logic.tuwien.ac.at>
Date: Fri, 25 May 2001 10:48:12 +0200 (MEST)
Organization: I'm not organized
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
To: Norbert Preining <preining@logic.at>
Subject: RE: ac15 and 2.4.5-pre6, pwc format conversion
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On 25-May-01 Norbert Preining wrote:
> Hi!
> 
> According to ac ChangeLog:
> o       Rip format conversion out of the pwc driver     (me)
>         | It belongs in user space..
> 
> This change is included in 2.4.5-pre6, but
>       drivers/usb/pwc-uncompress.c
> still relies on this files:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.5.6-packet/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -DEXPORT_SYMTAB -c
> pwc-uncompress.c
> pwc-uncompress.c:25: vcvt.h: No such file or directory
> pwc-uncompress.c: In function `pwc_decompress':
> pwc-uncompress.c:158: warning: implicit declaration of function
> `vcvt_420i_rgb24'
> pwc-uncompress.c:161: warning: implicit declaration of function
> `vcvt_420i_bgr24'
> pwc-uncompress.c:164: warning: implicit declaration of function
> `vcvt_420i_rgb32'
> pwc-uncompress.c:167: warning: implicit declaration of function
> `vcvt_420i_bgr32'
> pwc-uncompress.c:171: warning: implicit declaration of function
> `vcvt_420i_yuyv'
> pwc-uncompress.c:185: warning: implicit declaration of function
> `vcvt_420i_420p'

That´s what you get for ripping out the guts of a driver. Have a nice day.

 - Nemosoft (the pwc module maintainer)

-----------------------------------------------------------------------------
Try SorceryNet!   One of the best IRC-networks around!   irc.sorcery.net:9000
URL: never        IRC: nemosoft      IscaBBS (bbs.isca.uiowa.edu): Nemosoft
                        >> Never mind the daylight << 
