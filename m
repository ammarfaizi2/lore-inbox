Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAVIRQ>; Mon, 22 Jan 2001 03:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAVIRG>; Mon, 22 Jan 2001 03:17:06 -0500
Received: from ns1.megapath.net ([216.200.176.4]:35084 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129401AbRAVIQ4>;
	Mon, 22 Jan 2001 03:16:56 -0500
Message-ID: <3A6BED1D.86D5B597@megapathdsl.net>
Date: Mon, 22 Jan 2001 00:19:41 -0800
From: Miles Lane <miles@megapathdsl.net>
Reply-To: miles@megapathdsl.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Running "make install" runs lilo on my Athlon but not my Pentium II.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When I run "make install" on my Pentium II machine, lilo gets
run after vmlinuz is built.  When I do the same thing on my Athlon,
vmlinuz gets built, but lilo does get run.

Here are my architecture options for the Athlon:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
