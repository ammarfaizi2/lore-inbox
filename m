Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293136AbSBWUqK>; Sat, 23 Feb 2002 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSBWUqB>; Sat, 23 Feb 2002 15:46:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:54802 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293136AbSBWUpz>; Sat, 23 Feb 2002 15:45:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 23 Feb 2002 12:48:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] /dev/epoll bug fix ...
Message-ID: <Pine.LNX.4.44.0202231245280.1449-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was a bug inside the pipe code that was triggered by certain
patterns in SMP mode ( thanks to  Ken Brownfield  for the report ) :

http://www.xmailserver.org/linux-patches/nio-improve.html
http://www.xmailserver.org/linux-patches/ep_patch-2.4.17-0.29.diff
http://www.xmailserver.org/linux-patches/ep_patch-2.5.5-0.29.diff




- Davide



