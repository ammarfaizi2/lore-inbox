Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTAZXFE>; Sun, 26 Jan 2003 18:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTAZXFE>; Sun, 26 Jan 2003 18:05:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:25816 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267043AbTAZXFD>; Sun, 26 Jan 2003 18:05:03 -0500
Date: Mon, 27 Jan 2003 01:07:40 +0100
From: Christian Zander <zander@minion.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christian Zander <zander@minion.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127000740.GJ394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126231232.GE394@kugai> <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> <30633.1043621749@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30633.1043621749@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 10:55:49PM +0000, David Woodhouse wrote:
> 
> /me blinks... what's wrong with 2.2? Looks fine to me...
> 
> imladris /home/dwmw2/working/mtd/drivers/mtd $ make LINUXDIR=/inst/linux/linux-2.2
> make -C /inst/linux/linux-2.2 SUBDIRS=`pwd` modules
> make[1]: Entering directory `/inst/linux/linux-2.2'
> make -C  /home/dwmw2/working/mtd/drivers/mtd CFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE"
> MAKING_MODULES=1 modules
>

I apologize if I have argued based on false assumptions; is it true
then that a Makefile written for use with Linux 2.5 kbuild will work
unchanged with any Linux 2.2/2.5 kernel (w/ custom CFLAGS, ...)?

-- 
christian zander
zander@minion.de
