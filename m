Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSHWPDQ>; Fri, 23 Aug 2002 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSHWPDQ>; Fri, 23 Aug 2002 11:03:16 -0400
Received: from pD9E2385F.dip.t-dialin.net ([217.226.56.95]:16281 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318835AbSHWPDQ>; Fri, 23 Aug 2002 11:03:16 -0400
Date: Fri, 23 Aug 2002 09:07:01 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Steven Cole <elenstev@mesatop.com>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>, Alan Cox <alan@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4-ac1 (this time regarding 2.5.31)
In-Reply-To: <1030114387.4029.22.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0208230902170.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23 Aug 2002, Steven Cole wrote:
> [steven@spc9 linux-2.4.20-pre4-ac1]$ find . -name "*.c" | xargs grep -l "__, ##"
> ./drivers/video/aty128fb.c
> ./drivers/usb/brlvger.c
> ./drivers/ieee1394/sbp2.c
> ./arch/arm/mach-sa1100/system3.c

On 2.5, we have (regarding macro madness):

arch/arm/mach-sa1100/system3.c
drivers/video/aty128fb.c
drivers/ieee1394/sbp2.c
drivers/pcmcia/sa1100_system3.c

Regarding __FUNCTION__ concatenation, there is:

fs/jbd/revoke.c
net/ipv4/netfilter/ipt_ULOG.c
arch/cris/drivers/usb-host.c
arch/parisc/kernel/ccio-dma.c
drivers/atm/firestream.c
drivers/net/wan/cycx_drv.c
drivers/usb/misc/brlvger.c
drivers/usb/class/bluetty.c
drivers/char/sx.c
drivers/char/generic_serial.c
drivers/char/machzwd.c
drivers/scsi/pcmcia/nsp_message.c
drivers/scsi/pcmcia/nsp_cs.c
security/security.c

If somebody tells me which method is being preferred, I'll take it up. So 
please speak up!

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

