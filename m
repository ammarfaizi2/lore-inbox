Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSKZPXr>; Tue, 26 Nov 2002 10:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSKZPXr>; Tue, 26 Nov 2002 10:23:47 -0500
Received: from tao-eth.natur.cuni.cz ([195.113.46.57]:6922 "EHLO
	tao.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S266363AbSKZPXp>; Tue, 26 Nov 2002 10:23:45 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Tue, 26 Nov 2002 16:31:00 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic with 2.4.20-rc3
Message-ID: <Pine.OSF.4.44.0211261616490.71135-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have a kernel panic on ASUS A7V333 ACPI BIOS Rev 1014 Beta 002 system,
no SMP kernel, HIGMEM enabled with Athlon 2000+:

BTW: Would someone tell me how to save the stack trace, so I do not have
to write it down manually? Thanks. ;)

On the console is left:

Real Time Clock Driver: v1.10e
amd76x_pm: version 20020730
Unable to handle kernel NULL pointer dereference at virtual address 00000026
printing eip:
c01cd7fd
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01cd7fd>]		Not tainted
EFLAGS: 00010246
eax: 00000000 ebx: 00000000 ecx: c031a070 edx: 00001022
esi: c034ffc4 edi: 00000000 ebp: 0008e000 esp: c1c17fc8
ds: 0018 es: 0018 ss:0018
Process swapper (pid: 1, stackpage = c1c17000)
Stack: c036922c c035cf24 c02c5c12 c02c5c09 c035075a 00010f00 c035079f c0105037
	00010f00 c034ffc4 c01055b8 00000000 00000078 0009fe00
Call trace: [<c0105037>][<c0155b8>]
Code: 0f b7 40 26 3d 13 74 00 00 74 09 3d 43 74 00 00 74 11 eb 1f
<0> Kernel panic: Attempted to kill init!

after a while appeared

spurious 8259A interrupt: IRQ7

Needless to say this surious interrupt I've seen also on this machine running 2.4.19 kernel.

Any ideas what should I do? I'm a bit new to debugging kernel. ;)
Please Cc: me in replies. Thanks!
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585

