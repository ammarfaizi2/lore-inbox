Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJ0K1z>; Sun, 27 Oct 2002 05:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJ0K1z>; Sun, 27 Oct 2002 05:27:55 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:5579 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261340AbSJ0K1z>; Sun, 27 Oct 2002 05:27:55 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 27 Oct 2002 02:33:29 -0800
Message-Id: <200210271033.CAA02842@adam.yggdrasil.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Pauses in 2.5.44 (some kind of memory policy change?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I run /usr/bin/mail to read my mail box file, which has about
24 megabytes (in 2300 messages, mostly spam).  After this, about half
of the time, my keyboard and mouse will intermittently stop responding
for a second or two, maybe one or two times, and then everything
seems to be OK.  This happens *after* the mail spool has been read.
This did not happen in previous kernels (well, maybe 2.5.43, I can't
quite be sure about that one).

	The mail spool is on NFS, but I suspect the culprit might be
some kind of memory balancing change in 2.5.44.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


