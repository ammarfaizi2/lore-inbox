Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSC1Fav>; Thu, 28 Mar 2002 00:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311650AbSC1Fak>; Thu, 28 Mar 2002 00:30:40 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:56960 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S311618AbSC1Fa0>; Thu, 28 Mar 2002 00:30:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 27 Mar 2002 21:35:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] /dev/epoll update
Message-ID: <Pine.LNX.4.44.0203272128480.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- module setup not works for real ( missed export-objs entry )
- fixed a bug that caused random kernel crashes if the server crashed
  while it was handling pretty-high ( > 60k on my machine ) number of fds
  ( thx to  Yan-Fa Li  for ksymops reports )

http://www.xmailserver.org/linux-patches/nio-improve.html#patches



- Davide



