Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276541AbRI2QUR>; Sat, 29 Sep 2001 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276540AbRI2QUH>; Sat, 29 Sep 2001 12:20:07 -0400
Received: from www.fagotten.org ([212.73.164.10]:14097 "EHLO
	joxer.fagotten.org") by vger.kernel.org with ESMTP
	id <S276539AbRI2QT5>; Sat, 29 Sep 2001 12:19:57 -0400
Message-ID: <3BB5F4C6.DDB15B49@fagotten.org>
Date: Sat, 29 Sep 2001 18:20:22 +0200
From: Daniel Elvin <daniel.elvin@fagotten.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.17-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: AST P/75 causes Machine Check Exception type 0x9 on v2.4.10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
Booting an AST Bravo P/75 with kernel v2.4.10 results in a "CPU#0
Machine Check Exception: 0x10C938 (type: 0x9)".

Description
The AST Bravo P/75
<http://www.ari-service.com/support/summary.asp?pn=501701-411&x=26&y=12>
boots fine on a v2.2.19pre17-kernel but both v2.4.10 and v2.4.9 causes
the Machine Check Exception-error with either of the config options
M586TSC, M586, or M386 set. A TB from AST
<http://www.ari-service.com/bulletin/TB/1641TB.HTM> reports a problem
with parity checking using Netware on a number of AST Pentium computers,
caused by the cache parity bit connector to the Pentium processor isn't
connected to the cache. I have not found any information if this is also
the case of the Bravo P/75. 

Keywords
2.4.10, Machine Check Exception, AST Bravo P/75.

Regards,
Daniel Elvin

=========================================
 Daniel Elvin  daniel.elvin@fagotten.org
=========================================
 Flojtvagen 8B     phone: +46 708 159351
 SE-224 68 Lund
 Sweden
