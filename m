Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbTCZOU2>; Wed, 26 Mar 2003 09:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbTCZOU2>; Wed, 26 Mar 2003 09:20:28 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:7552 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261559AbTCZOU1>; Wed, 26 Mar 2003 09:20:27 -0500
Date: Wed, 26 Mar 2003 08:31:40 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: jsimmons@infradead.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: fbcon sleeping function call from illegal context
Message-ID: <Pine.LNX.4.44.0303260821590.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you wrote
---------------------- 
Please try my patch I sent to Ben. I attached it to this email for people
to try it.

diff -urN -X /home/jsimmons/dontdiff 
linus-2.5/drivers/video/console/fbcon.c \
                fbdev-2.5/drivers/video/console/fbcon.c
--- linus-2.5/drivers/video/console/fbcon.c     Sat Mar 22 21:45:23 2003
+++ fbdev-2.5/drivers/video/console/fbcon.c     Tue Mar 25 12:03:56 2003
--------------------

One hunk applied with fuzz and two hunks were rejected when applied both 
to 2.5.66 stock and bk-latest.  I fixed up the rejects by hand and 
compiled a new kernel against bk-latest.  I am running with that version 
now, which doesn't emit the string of messages I reported originally.  The 
only minor anomaly I note is the cursor is a three-segment underscore 
rather than a solid underscore.  

