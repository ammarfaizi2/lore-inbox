Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268092AbTBMRLC>; Thu, 13 Feb 2003 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbTBMRLC>; Thu, 13 Feb 2003 12:11:02 -0500
Received: from dsl-212-144-252-041.arcor-ip.net ([212.144.252.41]:9601 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S268092AbTBMRLA>; Thu, 13 Feb 2003 12:11:00 -0500
Date: Thu, 13 Feb 2003 18:20:51 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de
Subject: 2.5.60: HiSax build error
Message-ID: <20030213172051.GA5063@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know old ISDN drivers are deprecated with 2.5.60 but still they are
available to choose and so I did.
The build resulted in an error at HiSax:

   ld -m elf_i386  -r -o drivers/isdn/hisax/built-in.o
drivers/isdn/hisax/hisax.o drivers/isdn/hisax/hisax_isac.o
drivers/isdn/hisax/hisax_fcpcipnp.o drivers/isdn/hisax/hisax_hfcpci.o
drivers/isdn/hisax/hisax_isac.o: In function `isac_setup':
drivers/isdn/hisax/hisax_isac.o(.text+0x820): multiple definition of `isac_setup'
drivers/isdn/hisax/hisax.o(.text+0x18800): first defined here
ld: Warning: size of symbol `isac_setup' changed from 39 to 588 in
drivers/isdn/hisax/hisax_isac.o


Linux neon 2.4.21-pre4-ac4 #1 Thu Feb 13 17:09:22 CET 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11w
mount                  2.11w
module-init-tools      0.9.7
e2fsprogs              1.32
jfsutils               1.1.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sr_mod nvidia nfs ntfs


Best regards,
Axel Siebenwirth
