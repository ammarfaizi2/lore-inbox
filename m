Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbRCXNot>; Sat, 24 Mar 2001 08:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRCXNok>; Sat, 24 Mar 2001 08:44:40 -0500
Received: from gepetto.dc.luth.se ([130.240.42.40]:49032 "EHLO
	gepetto.dc.luth.se") by vger.kernel.org with ESMTP
	id <S131670AbRCXNoW>; Sat, 24 Mar 2001 08:44:22 -0500
Date: Sat, 24 Mar 2001 14:43:34 +0100 (MET)
Message-Id: <200103241343.f2ODhYF14378@gepetto.dc.luth.se>
From: André Dahlqvist <anedah-9@student.luth.se>
To: linux-kernel@vger.kernel.org
Reply-To: André Dahlqvist <anedah-9@student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 213.65.234.48
Subject: MD5 check failes for ISDN related files on 2.4.2-ac24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spotted these messages during 'make dep' on
2.4.2-ac24:

make -C hisax fastdep
md5sum: MD5 check failed for 'isac.c'
md5sum: MD5 check failed for 'isdnl1.c'
md5sum: MD5 check failed for 'isdnl2.c'
md5sum: MD5 check failed for 'isdnl3.c'
md5sum: MD5 check failed for 'tei.c'
md5sum: MD5 check failed for 'callc.c'
md5sum: MD5 check failed for 'cert.c'
md5sum: MD5 check failed for 'l3dss1.c'
md5sum: MD5 check failed for 'l3_1tr6.c'
md5sum: MD5 check failed for 'elsa.c'
md5sum: MD5 check failed for 'diva.c'
md5sum: MD5 check failed for 'sedlbauer.c'

They all seam to be related to the ISDN code. Is this
something to worry about?
-- 

André Dahlqvist <anedah-9@sm.luth.se>
