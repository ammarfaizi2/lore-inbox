Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUGPJQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUGPJQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGPJQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:16:33 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:61482 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S266501AbUGPJQU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:16:20 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Kernel oops while shutting down (2.6.8rc1)
Date: Fri, 16 Jul 2004 10:11:36 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407161011.36677.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Unable to handle kernel paging requested:
at virtual address d0967287
printing eip:
*pde = 0fe43067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: sg st sr_mod sd_mod scsi_mod ide_cd cdrom i830 ipv6 
i810_audio ac97_codec soundcore af_packet usbhid floppy airo_cs ds airo 
pcmcia_core d
CPU:    0
EIP:    0060:[<d0967287>]    Not tainted
EFLAGS: 00010296   (2.6.8-rc1)
EIP is at 0xd0967287
eax: 00000000   ebx: 00375140   ecx: 00000008   edx: 00000001
esi: c1265cf8   edi: 00374366   ebp: c1265c00   esp: c03adfb4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03ac000 task=c032ca40)
Stack: 00425007 d0967167 0000007b c03a007b 00000000 c03ac000 0009fb00 c03da120
       00425007 c01040dd 00000006 c03ae7cf c032ca40 00000000 c03d3774 00000018
       c03ae380 c03db580 c010019f
Call Trace:
 [<c01040dd>] cpu_idle+0x2d/0x40
 [<c03ae7cf>] start_kernel+0x18f/0x1d0
 [<c03ae380>] unknown_bootoption+0x0/0x170
Code:  Bad EIP value.
<0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA95vIBn4EFUVUIO0RApZ/AKCzO+JbcNW7HdkXSXUP1bjxllskrgCfQYJD
6pp1Hm7AT6GkqDAeP1rvBvU=
=E1mQ
-----END PGP SIGNATURE-----
