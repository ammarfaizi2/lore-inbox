Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUJ3VP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUJ3VP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUJ3VPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:15:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63931 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261325AbUJ3VOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:14:52 -0400
Subject: code bloat [was Re: Semaphore assembly-code bug]
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
	 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 17:14:50 -0400
Message-Id: <1099170891.1424.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 00:00 +0300, Denis Vlasenko wrote:
> If only glibc / X / KDE / OpenOffice (ugggh) people could hear you more...
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
> 15364 root      15   0 38008  26M 28496 S     0,0 10,8   0:57   0 kmail
> 20022 root      16   0 40760  24M 23920 S     0,1 10,0   0:04   0 mozilla-bin
>  1627 root      14  -1 71064  19M 53192 S <   0,1  7,9   3:16   0 X
>  1700 root      15   0 25348  16M 23508 S     0,1  6,5   0:46   0 kdeinit
>  3578 root      15   0 24032  14M 21524 S     0,5  5,8   0:23   0 konsole

Wow. evolution is now more bloated than kmail.

 1424 rlrevell  15   0  125m  47m  29m S  7.8 10.1   1:41.78 evolution
 1508 rlrevell  15   0 92432  30m  29m S  0.0  6.4   0:14.15 mozilla-bin
 1090 root      16   0 55676  18m  40m S 24.8  3.9   0:46.98 XFree86
 1379 rlrevell  15   0 33776  16m  18m S  0.3  3.5   0:06.65 nautilus
 1377 rlrevell  15   0 19392  11m  15m S  0.0  2.5   0:03.29 gnome-panel
 1458 rlrevell  16   0 28188  11m  15m S  3.9  2.5   0:10.44 gnome-terminal
 1307 rlrevell  15   0 20828  11m  17m S  0.0  2.4   0:03.08 gnome-settings-

Lee

