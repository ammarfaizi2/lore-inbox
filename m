Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKFK0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKFK0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKFK0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:26:44 -0500
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:32701 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261356AbUKFK0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:26:41 -0500
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: support of older compilers
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <2Xj2s-5vj-33@gated-at.bofh.it>
Date: Sat, 06 Nov 2004 10:15:55 GMT
Message-ID: <2004Nov6.111555@mips.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds:
>
>
>On Fri, 5 Nov 2004, Chris Wedgwood wrote:
>
>> On Fri, Nov 05, 2004 at 07:41:03AM -0800, Linus Torvalds wrote:
>> 
>> > > -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
>> > > -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2
>> 
>> > Ok, you da man. What do you use it for? Or is it just lying around
>> > for nostalgic reasons?
>> 
>> to remind us how large the kernel is getting? :)
>
>Yeah, I know. Damn, it's scary. We should probably have some
>per-object-file statistics, and try to make people more aware of big bad
>things.

I can't offer that, but at least some more historic data on kernels
for my machines:

[~:42349] ls -ltr /boot|grep linu
...    231940 Mar 15  1994 vmlinux              #1.0
...    219652 Jul 19  1994 vmlinux_ethernet     #1.0
...    265188 Dec  7  1994 vmlinux-1.1.59-net
...    273380 Mar 29  1995 vmlinux-1.2.1
...    273412 Jun  4  1995 vmlinux-1.2.9
...    293892 Oct 26  1995 vmlinux-1.2.9-idecd
...    281604 Dec  9  1995 vmlinux-1.2.13
...    310276 May  9  1996 vmlinux-1.2.13-scsi
...    330756 Oct 30  1996 vmlinux-1.2.13-scsi-sound
...    446281 Dec  8  1997 vmlinuz-2.0.32-rh5.0
...    425237 Dec 20  1997 vmlinuz-2.0.32
...    381607 Jun 24  1998 vmlinuz-2.0.34
...    358407 Jul  3  1998 vmlinuz-2.0.34-2
...    480144 Sep 22  1998 vmlinuz-2.1.122
...    452853 Feb  9  1999 vmlinux-2.2.1
...    617431 May  8  1999 vmlinuz-2.2.5-15
...    721343 Dec 18  1999 vmlinuz-suse
...    500762 Jan 26  2000 vmlinux-2.2.14
...    728255 Nov 28  2000 vmlinux-2.4.0-test11
...    737572 Jun  3  2001 vmlinux-2.4.0-test11-cdrw
...    737575 May 10  2002 vmlinux-2.4.0-test11-usb
...    811903 Sep 26  2002 vmlinux-2.4.19
...   1330830 Nov 27  2003 vmlinux-2.4.21-suse
...   1270508 Nov 29  2003 vmlinuz-2.4.20-bf2.4
...   1322073 Feb 18  2004 vmlinuz-2.4.22-1.2174.nptl
...   1099371 Apr  4  2004 vmlinuz-2.4.25-amd64-nonetfilter
...   1101157 Apr  4  2004 vmlinuz-2.4.25-amd64
...   1062450 Apr  4  2004 vmlinuz-2.4.25-i386
...   1052249 Apr 13  2004 vmlinuz-2.4.25-i386-noagp
...   1068566 Apr 18  2004 vmlinuz-2.4.25-amd64-20040418
...   1017406 Apr 29  2004 vmlinuz-2.4.26-amd64
...   1271027 May  4  2004 vmlinuz-2.6.5-amd64
...   1271488 May  9 20:15 vmlinuz-2.6.5-amd64-20040509

I also still have a number of them in my LILO menu that probably don't
work:-)

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
