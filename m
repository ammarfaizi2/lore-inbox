Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVHYJkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVHYJkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVHYJkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:40:07 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:9373 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S964909AbVHYJkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:40:05 -0400
Date: Thu, 25 Aug 2005 11:40:04 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: Incorrect kcore size
Message-ID: <Pine.BSO.4.62.0508251133350.24991@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-656959031-1124962804=:24991"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-656959031-1124962804=:24991
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT


Two cases:

# uname -a; free | grep Mem; ls -l /proc/kcore
Linux v100 2.6.11-1.1166sp1 #1 Fri Mar 4 20:41:51 EST 2005 sparc64 sparc64 sparc64 GNU/Linux
Mem:       1031152     100976     930176          0      22208      32232
-r--------  1 root root 3756826624 Aug 25 11:28 /proc/kcore

# uname -a; free | grep Mem; ls -l /proc/kcore
Linux test1 2.6.12-1.1504_FC5smp #1 SMP Sun Aug 21 01:46:21 EDT 2005 i686 athlon i386 GNU/Linux
Mem:       2074664    2007592      67072          0     127876    1209816
-r--------  1 root root 939528192 sie 25 11:36 /proc/kcore

Additionaly in first case /proc/kcore cant be stated by mc.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-656959031-1124962804=:24991--
