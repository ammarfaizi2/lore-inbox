Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbVHZKpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbVHZKpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 06:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVHZKpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 06:45:07 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:15085 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932539AbVHZKpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 06:45:06 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: Linux-2.6.13-rc7
Date: Fri, 26 Aug 2005 10:45:01 +0000 (UTC)
Organization: Cistron
Message-ID: <demrrd$si6$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
X-Trace: ncc1701.cistron.net 1125053101 29254 62.216.30.70 (26 Aug 2005 10:45:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  <torvalds@osdl.org> wrote:
> I really wanted to release a 2.6.13, but there's been enough changes 
>while we've been waiting for other issues to resolve that I think it's 
>best to do a -rc7 first.
>
>Most of the -rc7 changes are pretty trivial, either one-liners or 
>affecting some particular specific driver or unusual configuration. The 
>shortlog (appended) should give a pretty good idea of what's up.
>
>		Linus

OK, i tried rc7 on my newsgateway and so far it keeps running after 50+
hours of 200megabit in & 200 megabitoutgoing network traffic and
sufficient storage to the scsi system.

Of course it will probably reboot just after sending this message.
If it stays up after 5 days of pounding it will get _my_ stamp of
aproval ;-)

----------
Linux 2.6.13-rc7 (root@newsgate) (gcc [can't parse]) #???  1CPU [newsgate.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       2058040     2041552       16488           0         616
Swap:            0           0           0

Bootup: Wed Aug 24 09:50:30 2005    Load average: 3.39 3.25 3.16 2/80 12244

user  :       5:06:34.95  10.0%  page in :        0
nice  :       0:42:50.54   1.4%  page out:        0
system:      16:22:48.44  32.2%  swap in :        0
idle  :       0:25:08.22   0.8%  swap out:        0
uptime:   2d  2:53:38.68         context :592311164

irq  0:  45792855 timer                 irq 12:         3
irq  1:         8 i8042                 irq 24:  56420796 aic79xx
irq  2:         0 cascade [4]           irq 25: 479838182 aic79xx, eth3
irq  4:       369 serial                irq 28:1007452070 acenic
irq  8:         0 rtc

----------

Danny



