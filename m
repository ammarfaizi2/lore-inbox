Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUEMIUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUEMIUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUEMIUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:20:30 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.125.5]:56326 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263928AbUEMIUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:20:08 -0400
Date: Thu, 13 May 2004 10:13:34 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ERROR] kernel 2.6.6 on SPARC64 
Message-ID: <Pine.LNX.4.58L.0405131009460.6011@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2097517980-2055131686-1084436014=:6011"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2097517980-2055131686-1084436014=:6011
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I try to build kernel 2.6.6 on my machine UltraSPARC II
But i got error [config in attachment]:
[...]
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/sparc64/kernel/built-in.o(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x14): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x2c): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x34): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x3c): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x44): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x4c): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x54): relocation truncated to fit: R_SPARC_WDISP22 .text
arch/sparc64/kernel/built-in.o(.fixup+0x5c): additional relocation overflows omitted from the output
drivers/built-in.o(.text+0xfb448): In function `hamachi_rx':
: undefined reference to `bus_to_virt_not_defined_use_pci_map'
local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
local symbol 1: discarded in section `.exit.text' from drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

Can anyone tell me what's wrong ?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
--2097517980-2055131686-1084436014=:6011
Content-Type: APPLICATION/x-gzip; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0405131013340.6011@alpha.zarz.agh.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="config.gz"

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
yQb1u44hinshGMxbXi+Kttr+B3OzSolTXQAA

--2097517980-2055131686-1084436014=:6011--
