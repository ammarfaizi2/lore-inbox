Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSL3MjR>; Mon, 30 Dec 2002 07:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSL3MjR>; Mon, 30 Dec 2002 07:39:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55168
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266936AbSL3MjP>; Mon, 30 Dec 2002 07:39:15 -0500
Subject: Re: Current unclaimed 2.5 bugs on bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: kernel-janitors@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <129460000.1041214462@titus>
References: <129460000.1041214462@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 13:27:57 +0000
Message-Id: <1041254877.13076.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 02:14, Martin J. Bligh wrote:
> 118 blo mbligh@aracnet.com OPEN Load IDE-SCSI module causes OOPS in 2.5.49

Mine

> 138 nor khoa@us.ibm.com OPEN Build error: drivers/video/sis/sis_main.h:299: 
> parse erro...
> 153 nor mbligh@aracnet.com OPEN compile failure on drivers/char/riscom8.c
> 154 nor mbligh@aracnet.com OPEN compile failure on drivers/char/esp.c
> 155 nor mbligh@aracnet.com OPEN compile failure on drivers/char/specialix.c

These three have no maintainer, and will probably not get fixed for a
while - someone has to move them to work queues etc and to do that
someone has to fix the broken tty layer locking in 2.5

> 162 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/bttv-cards.c

Patch has been pending for Linus since about 2.5.50 from Gerd

> 167 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/zr36120.c

Probably won't get fixed for a while yet

> 168 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/saa7185.c

Fixed in -ac I think

> 169 nor khoa@us.ibm.com OPEN compile failure on drivers/media/video/bt819.c

Fixed in -ac I think

> 185 low mbligh@aracnet.com OPEN mwave init yields: bad: scheduling while 
> atomic!

I've got a thinkpad so feel free to assign that to me

> 195 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/zr36067.c

Won't get fixed for a while

> 196 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/stradis.c

Needa major work from the maintainer I suspect.
> 197 nor khoa@us.ibm.com OPEN compile failure on 
> drivers/media/video/tda9887.o

Fixed in -ac I think

> 202 nor mbligh@aracnet.com OPEN compile failure on 
> drivers/net/irda/vlsi_ir.c

Fixed in -ac

> 205 low mbligh@aracnet.com OPEN gpm mouse cursor flips chars on framebuffer 
> console
> 206 nor mbligh@aracnet.com OPEN broken colors on framebuffer console
> 207 blo mbligh@aracnet.com OPEN Cirrus Logic Framebuffer -- Does not compile
> 209 nor mbligh@aracnet.com OPEN Matrox Framebuffer -- Does not compile

Really James Simmons is the person to get all the framebuffer bugs (and
probably by now close a lot of them)

Alan

