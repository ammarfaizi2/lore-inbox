Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSKMTFV>; Wed, 13 Nov 2002 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSKMTFV>; Wed, 13 Nov 2002 14:05:21 -0500
Received: from naig.caltech.edu ([131.215.49.17]:39838 "EHLO naig.caltech.edu")
	by vger.kernel.org with ESMTP id <S262425AbSKMTFU>;
	Wed, 13 Nov 2002 14:05:20 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: not-for-mail
From: Stuart Anderson <sba@srl.caltech.edu>
Newsgroups: mlist.linux.kernel
Subject: sk98lin driver in 2.5.47
Date: Wed, 13 Nov 2002 19:12:10 +0000 (UTC)
Organization: Caltech
Message-ID: <slrnat590a.rui.sba@jelly.caltech.edu>
Reply-To: -@-
NNTP-Posting-Host: jelly.ligo.caltech.edu
X-Trace: naig.caltech.edu 1037214730 20732 131.215.115.246 (13 Nov 2002 19:12:10 GMT)
X-Complaints-To: abuse@caltech.edu
NNTP-Posting-Date: Wed, 13 Nov 2002 19:12:10 +0000 (UTC)
User-Agent: slrn/0.9.7.4 (SunOS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been unable to compile the SysKonnect sk98lin GigE driver
under linux-2.5.x. Is there a patch for the following linker
problem of built-in.o? The following is from 2.5.47-ac2.

Thanks.

drivers/built-in.o: In function `SkPnmiInit':
drivers/built-in.o(.text+0x3a346): undefined reference to `__udivdi3'
drivers/built-in.o: In function `SkPnmiEvent':
drivers/built-in.o(.text+0x3ae97): undefined reference to `__udivdi3'
drivers/built-in.o: In function `SensorStat':
drivers/built-in.o(.text+0x3c0fd): undefined reference to `__udivdi3'
drivers/built-in.o(.text+0x3c16d): undefined reference to `__udivdi3'
drivers/built-in.o: In function `General':
drivers/built-in.o(.text+0x3de99): undefined reference to `__udivdi3'



-- 
Stuart Anderson  sba@srl.caltech.edu  http://www.srl.caltech.edu/personnel/sba
