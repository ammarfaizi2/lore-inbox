Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUDRQZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUDRQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 12:25:42 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:45508 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262113AbUDRQZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 12:25:41 -0400
Subject: 2.6.5 pts problem
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082305539.15497.2.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 19:25:40 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I noticed something strange this day last week:
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
midian   :0       -                Thu20   ?xdm?   1:32m  2.98s
/usr/bin/gnome-session
midian   pts/0    :0.0             Thu20    1:49  18.91s 18.91s ssh midi
midian   pts/51   :0:S.0           Thu22    1:33   6.43s  6.43s irssi
midian   pts/92   :0.0             19:08   14:19   2.14s  2.14s ncftp
ftp.fi.netbsd.org
midian   pts/93   :0.0             19:24    0.00s  0.00s  0.00s w
             ^^
As you see, pts is just growing, not using the old used numbers.

        Markus

