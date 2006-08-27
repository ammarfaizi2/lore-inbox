Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWH0Mge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWH0Mge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 08:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWH0Mgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 08:36:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34509 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932099AbWH0Mgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 08:36:33 -0400
Date: Sun, 27 Aug 2006 14:35:47 +0200 (MEST)
Message-Id: <200608271235.k7RCZlru005427@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, wtarreau@hera.kernel.org
Subject: Re: Linux 2.4.33.2
Cc: gcoady.lk@gmail.com, mtosatti@redhat.com, volkerdi@slackware.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 21:23:00 +0000, Willy Tarreau wrote:
>### Important note for users of Slackware 10.2 ###
>
>Grant Coady informed me that 2.4.33.1 did not boot for him. After a long
>series of tests from him and Pat Volkerding, it appeared that the problem
>is caused by glibc 2.3.6 wrongly detecting kernel version as 4.33.1 and
>mistakenly using the NTPL libs instead.
>
>Patrick has fixed the problem and will (has ?) send the fix to the glibc
>team. By now people using Slackware 10.2 must upgrade their glibc to
>glibc-solibs-2.3.5-i486-6_slack10.2.tgz if they want to run a 2.4.33.x
>kernel (user glibc-2.3.6 build -5 for -current). A workaround is either
>to rename /lib/tls or to rename the kernel to something different than
>4 numbers separated by dots. Since the problem is fixed, I don't intend
>to change the numbering.
>
>I dont think that this problem might affect many other distros since those
>shipping an NPTL-enabled libc with both 2.4 and 2.6 mainline are rare. If
>anyone else encounters the problem, Pat has the fix.

Can anyone provide a URL to the glibc fix?
While I don't use Slackware and haven't been bitten by
the bug (yet), I want to review the fix for possible
inclusion in my glibc patch kit.

/Mikael
