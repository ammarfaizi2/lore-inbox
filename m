Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276175AbRI1RHT>; Fri, 28 Sep 2001 13:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276170AbRI1RHJ>; Fri, 28 Sep 2001 13:07:09 -0400
Received: from [204.143.35.11] ([204.143.35.11]:2572 "EHLO
	IPBML001.velceroisp.com") by vger.kernel.org with ESMTP
	id <S276175AbRI1RGz>; Fri, 28 Sep 2001 13:06:55 -0400
From: "Matt McLaughlin" <darklord@velceroisp.com>
To: <linux-kernel@vger.kernel.org>
Subject: Bug Report.  Compiling probs w/ kernel 2.4.9
Date: Fri, 28 Sep 2001 10:03:47 -0700
Message-ID: <GDEELKOGMNFMMCALEOAIGEAKCAAA.darklord@velceroisp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  To linux-kernel@vger.kernel.org:

  In trying to compile linux-2.4.9 with support for NTFS filesystem +w
perms.
Even though it is dangerous (supposevily) the kernel would still NOT
compile.

  So what I did to get it to compile was add '<linux/kernel.h>' to the
$kernel/fs/ntfs/unistr.c file.  Basically the only problem was that the
min(type,var1,var2) function was undeclared.

  Please make changes in the next release for future reference.  Thanks.

  -Matt 'DarkLord' McLaughlin

  Bio-Hazard Industries (c) 1994     darklord@velceroisp.com

