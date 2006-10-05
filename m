Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWJEHrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWJEHrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWJEHrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:47:51 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:24793 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWJEHru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:47:50 -0400
Subject: Free memory level in 2.6.16?
From: Steve Bergman <sbergman@rueb.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 02:48:47 -0500
Message-Id: <1160034527.23009.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some problems I was having with the CentOS4.4 kernel, I just
moved a box (x86 with 4GB ram) to 2.6.16.29 from kernel.org.

All is well, but I am curious about one thing.  This is a fairly memory
hungry box, serving about 40 gnome desktops via xdmcp.  All VM settings
are at the default.  Swappiness=60, min_free_kbytes=3831.

However, it seems to seek out about 150MB for the level of free memory
that it maintains.  Typically I see somewhere between 100MB an 500MB in
swap, buffers+cache is about 500MB, and 150MB is free.

If I cat from /dev/md0 to /dev/null, the free memory does go down, to
25MB or so,  but then I can watch as it seeks out about 150MB of free
memory.

To me, free memory is wasted memory.  Is this a bug or a feature?

Thanks for any enlightenment.



