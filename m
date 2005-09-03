Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVICRZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVICRZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVICRZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:25:51 -0400
Received: from smeagol.dreamhost.com ([66.33.209.5]:39842 "EHLO
	smeagol.dreamhost.com") by vger.kernel.org with ESMTP
	id S1750919AbVICRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:25:50 -0400
Message-ID: <4319DC91.4020406@jstenback.com>
Date: Sat, 03 Sep 2005 10:25:37 -0700
From: Johnny Stenback <jst@jstenback.com>
User-Agent: Mail/News 1.6a1 (X11/20050826)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gcc coredump with 2.6.12+ kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I just attempted to upgrade my kernel to 2.6.13. The kernel appears to 
boot and run just fine, but when I try to build any larger projects like 
Mozilla or the Linux kernel I constantly get segfaults from gcc. All 
other apps *seem* to work fine. I remember seeing this with 2.6.12 too 
when I tried to upgrade to it too but I didn't have the time to 
investigate at all then, but now I see the same problem with 2.6.13. The 
last version I've used that didn't show this problem is 2.6.11.3, and 
that's running with no problems here.

When gcc segfaults I get the following messages in the messages log:

cc1[16775]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
00007fffffaaf0a0 error 4
cc1[17086]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
00007fffffc4dfc0 error 4
cc1[17788]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
00007fffffd777e0 error 4
cc1[17823]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
00007fffffc4d630 error 4
cc1[17895]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
00007ffffffd2330 error 4

I'm on a dual AMD Opteron system, running x86_64 code. Using Fedora Core 
2 (yeah, old, I know...) and gcc 3.3.3 20040412.

I've ran memtest etc on this system, and with 2.6.11.3 and older kernels 
I've ran this system under moderate load for months w/o rebooting and 
I've never had any problems like this, so I'm fairly certain that I 
don't have bad hardware.

Anyone have any clues as to what could be causing this problem?

-- 
jst
