Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUEJCJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUEJCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUEJCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:09:28 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:50354 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264450AbUEJCJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:09:25 -0400
Date: Sun, 9 May 2004 19:08:41 -0700
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: No idea...
From: Brandon Lewis <dotsony@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F57F09EB-A226-11D8-BDEA-003065D7CDC2@earthlink.net>
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have an Alpha XL 266, running a fairly current unstable release 
of debian. I recently tried to compile 2.6.5 stable. The machine has an 
ISA sound card, which has sticker on it which says it's a SoundBlaster 
AWE32 PnP, though the isapnp tools do not detect any boards at all. I 
enabled the PNP BIOS options and the damn thing errored out during 
compile.

all through the compile process I kept seeing shit like

LD      drivers/net/tulip/built-in.o
   LD      drivers/net/built-in.o
   CC [M]  drivers/net/pppox.o
{standard input}: Assembler messages:
{standard input}:70: Warning: setting incorrect section attributes for 
.got
   CC [M]  drivers/net/pppoe.o
{standard input}: Assembler messages:
{standard input}:70: Warning: setting incorrect section attributes for 
.got
   LD      drivers/parport/built-in.o
   CC [M]  drivers/parport/share.o
{standard input}: Assembler messages:
{standard input}:70: Warning: setting incorrect section attributes for 
.got
   CC [M]  drivers/parport/ieee1284.o
{standard input}: Assembler messages:
{standard input}:70: Warning: setting incorrect section attributes for 
.got
   CC [M]  drivers/parport/ieee1284_ops.o
{standard input}: Assembler messages:


no idea what that's about, but I wouldn't have cared if some time later 
the thing hadn't errored out all together.

   CC      drivers/pnp/pnpbios/core.o
drivers/pnp/pnpbios/core.c:60:22: asm/desc.h: No such file or directory
drivers/pnp/pnpbios/core.c: In function `pnpbios_init':
drivers/pnp/pnpbios/core.c:504: error: `dmi_broken' undeclared (first 
use in this function)
drivers/pnp/pnpbios/core.c:504: error: (Each undeclared identifier is 
reported only once
drivers/pnp/pnpbios/core.c:504: error: for each function it appears in.)
drivers/pnp/pnpbios/core.c:504: error: `BROKEN_PNP_BIOS' undeclared 
(first use in this function)
make[3]: *** [drivers/pnp/pnpbios/core.o] Error 1
make[2]: *** [drivers/pnp/pnpbios] Error 2
make[1]: *** [drivers/pnp] Error 2
make: *** [drivers] Error 2

don't know wtf this is all about...but i'd sure like to use my sound 
card at some point...

