Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSI0QQ7>; Fri, 27 Sep 2002 12:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSI0QQ6>; Fri, 27 Sep 2002 12:16:58 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:34274 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261732AbSI0QQ5>; Fri, 27 Sep 2002 12:16:57 -0400
Date: Fri, 27 Sep 2002 13:21:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: procps-list@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] procps 2.0.8
Message-ID: <Pine.LNX.4.44L.0209271320240.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


		Procps 2.0.8
		27 Sep 2002


Procps is the package containing various system monitoring tools, like
ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
period of inactivity procps maintenance is active again and suggestions,
bugreports and patches are always welcome on the procps list.

The plan is to release a procps 2.1.0 around the time the 2.6.0 kernel
comes out, with maybe one extra intermediary release between now and
then.  Various features and code cleanups are planned, the /proc changes
in 2.5 are also sure to keep the procps maintainers busy...


You can download procps 2.0.8 from:

	http://surriel.com/procps/procps-2.0.8.tar.bz2

If you have feedback (or patches) for the procps team, feel free to
mail us at:

	procps-list@redhat.com


NEWS for version 2.0.8 of procps

* Integrate bugfixes and enhancements from all the vendor RPMs (Rik van Riel)
* Support new /proc layout, up to 2.5.39 or so. (Andrew Morton)
* Scheduler policy display in top and ps (Robert Love)
* Lots of compile cleanups and warning fixes (Robert Love)
* Support for understanding threads (Robert Love)
* Realtime priority and scheduling policy display for ps (Robert Love)
* Change meminfo() from an array into an actual struct, remove 60 lines
  of no longer needed code from free.c (Rik van Riel)
* Display active and inactive memory statistics from 2.4 and 2.5 kernels,
  in vmstat and top (Rik van Riel)
* A bug introduced by locale support was fixed; locales with , as the
  decimal point will work again.
* Libproc supports new process-migrating beowulf systems.



