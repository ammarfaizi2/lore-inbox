Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316128AbSEJVQR>; Fri, 10 May 2002 17:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316129AbSEJVQQ>; Fri, 10 May 2002 17:16:16 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:25095 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S316128AbSEJVQP>; Fri, 10 May 2002 17:16:15 -0400
Message-ID: <3CDC375D.6382AEC9@opersys.com>
Date: Fri, 10 May 2002 17:10:53 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Roman Zippel <zippel@linux-m68k.org>
Subject: [UPDATE] LTT patch for 2.5.15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following Roman's recommendations, I've updated the LTT patch
with the following changes:
- Modified code format to match Linux coding style
- Removed overweight comments
- Changed trace macros to static inlines
- Converted uint8_t, uint32_t and uint64_t to u8, u32 and u64
- Added <asm/trace.h> for architecture-dependent definitions

I've divided the patch in 4 parts:
1- Core tracing functionality
2- Trace driver
3- Architecture-dependent trace statements (i386, ppc, mips, s/390, sh)
4- Architecture-independent trace statements

Part X is available from:
ftp://ftp.opersys.com/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.15-vanilla-020510-1.14-part-X.gz

The patch is also available in one piece:
ftp://ftp.opersys.com/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.15-vanilla-020510-1.14.gz

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
