Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313138AbSDULkB>; Sun, 21 Apr 2002 07:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSDULkA>; Sun, 21 Apr 2002 07:40:00 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:31456 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S313138AbSDULkA>; Sun, 21 Apr 2002 07:40:00 -0400
Message-ID: <3CC2A517.19A82989@bigpond.com>
Date: Sun, 21 Apr 2002 21:40:07 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ttyS1 broken by 2.4.19-pre7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to talk to the modem on ttyS1 with just 2.4.19-pre7.
2.4.19-pre6 and 2.4.19-pre7-ac2 are fine.
The later two sources used were generated with diffs against
2.4.19-pre6, and the same initial .config for make oldconfig,
and CONFIG_IDE_TASKFILE_IO=y
    CONFIG_ZLIB_INFLATE=m
    CONFIG_ZLIB_DEFLATE=m
 the only new items for ac2.
