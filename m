Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLWVuk>; Sun, 23 Dec 2001 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281691AbRLWVua>; Sun, 23 Dec 2001 16:50:30 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:53004 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281779AbRLWVuP>; Sun, 23 Dec 2001 16:50:15 -0500
Date: Sun, 23 Dec 2001 13:52:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Time Slice Split Scheduler ...
Message-ID: <Pine.LNX.4.40.0112231340340.971-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implement a scheduler where the concept of dynamic priority is
separated from the concept of time slice, fixing/improving the current
scheduler behavior. The patch is described and is available here :

http://www.xmailserver.org/linux-patches/lnxsched.html#TsSplit

The same code can be easily merged inside the Balanced Multi Queue Scheduler
by keeping a per CPU rcl_curr variable.
I'm currently running this code on my machine and it behaves very well,
that means that when i run pine, it starts.
Comments ranging from "outstanding !!" down to "this code stink" are welcome.




- Davide




