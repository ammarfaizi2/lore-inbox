Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUBIQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBIQ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:57:17 -0500
Received: from web41308.mail.yahoo.com ([66.218.93.57]:60092 "HELO
	web41308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265078AbUBIQ5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:57:12 -0500
Message-ID: <20040209165711.2185.qmail@web41308.mail.yahoo.com>
Date: Mon, 9 Feb 2004 17:57:11 +0100 (CET)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: Re: Does anyone still care about BSD ptys?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPA asked:
 > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*? 

I do! I have an application that demultiplexes multiple serial streams
from a single one (to be exact this implements the multiplexing scheme
specified in 3GPP TS27.010 
(http://www.3gpp.org/ftp/Specs/latest/Rel-5/27_series/27010-500.zip).

The multiplexer uses old-style ptys to export the multiple streams 
to the applications (e.g. there are:
crw-rw-rw-    1 root     root       3, 236 May 21  2002 ttypMuxA0
crw-rw-rw-    1 root     root       3, 237 May 21  2002 ttypMuxA1
crw-rw-rw-    1 root     root       3, 238 May 21  2002 ttypMuxA2
crw-rw-rw-    1 root     root       3, 239 May 21  2002 ttypMuxA3
crw-rw-rw-    1 root     root       2, 236 May 21  2002 ptypMuxA0
crw-rw-rw-    1 root     root       2, 237 May 21  2002 ptypMuxA1
crw-rw-rw-    1 root     root       2, 238 May 21  2002 ptypMuxA2
crw-rw-rw-    1 root     root       2, 239 May 21  2002 ptypMuxA3).

It would be difficult to implement the same thing using SYSV ptys.

Regards
  Joerg


=====
-- 
Regards
       Joerg



	
		
Mit schönen Grüßen von Yahoo! Mail - http://mail.yahoo.de
