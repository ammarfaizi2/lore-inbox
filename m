Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281466AbRKHE4Q>; Wed, 7 Nov 2001 23:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281464AbRKHE4G>; Wed, 7 Nov 2001 23:56:06 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:6094 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281463AbRKHEzz>; Wed, 7 Nov 2001 23:55:55 -0500
Date: Thu, 8 Nov 2001 05:55:42 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: Sasha Pachev <sasha@mysql.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk
 I/O - 2.4.13
In-Reply-To: <200111080425.fA84Pdb04541@mysql.sashanet.com>
Message-ID: <Pine.LNX.4.40.0111080546030.12366-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.25)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Sasha Pachev wrote:

> Summary:
>
> System slowdown under unexplained excessive disk I/O
>
> Full description:
>
> While running X, KDE, having a few windows open, I ran make -j4 on MySQL
> source tree. I do this all the time and it usually works just fine - the
> system is a little bit unresponsive. However, occasionally the system becomes
> completely unresponsive - the disk goes crazy, the machine pings but neither
> ssh or telnet work - connection to the port is established, but nothing
> further than that. It does respond to magic SysRQ. I was able to get a memory
> info dump + stack traces into syslog, included below. The filesystem is
> ReiserFS.

I had a similar Problem while running sql-bench on Mysql ( must be mysql :-) ).
First I thought it happened since the Mysql-Tables were on the root-fs and
the Disk did not manage to retrieve normal libs and files for login usw.
But the System (2.4.14-pre8) took about 25 seconds to give a screen after
wakening from  apm (triggered by xscreensaver under gnome).
Console-Switching took even longer. Mouse-Movement stopped etc.
Disk-Activity was very high.

I had seen smaller Problems with huge loads on the root-fs earlier. But
never had a Problem with switching consoles or mouse.

Oktay

