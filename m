Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDSLUO>; Fri, 19 Apr 2002 07:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSDSLUN>; Fri, 19 Apr 2002 07:20:13 -0400
Received: from web10405.mail.yahoo.com ([216.136.130.97]:11013 "HELO
	web10405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312420AbSDSLUM>; Fri, 19 Apr 2002 07:20:12 -0400
Message-ID: <20020419112012.4188.qmail@web10405.mail.yahoo.com>
Date: Fri, 19 Apr 2002 21:20:12 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Kernel 2.4.19-pre6aa1 problem report (VM related)
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am testing 2.4.19-pre6aa1 for several days and today
I got the system totally freezed ; all I have is a
striped color screen, can not move mouse ; only thing
I could do is power off. This happened after about 8
hours ; just running Mozilla and just 15 minutes ago
the system began swapping. I check free and all swap
is used, then suddenly I got that screen. After power
off and on, I check messages and syslog, not any
usefull information.
(OOP or OOM or something similar I expect)

This symptom did not happen with 2.4.19-pre4-ac4  and
I remember I am rarely running out of swap.

This is a Intel celeron 400Mh, 128Mb RAM and 72Mb
swap. The kernel I said above is 2.4.19-pre6aa1  plus
ide-akpm.patch  

I notice that the aa kernel uses much more swap and
leave a lot of free RAM than the 2.4.19-pre4ac4
kernel. Responsiveness of both kernel are good even
when heavy swapping, but with aa kernel, swap is
easily running out while the 2.4.19-pre4ac4 not (even
run Mozilla, xmms, Star Office 5-2 and editting
document); but with aa only mozilla and running for
rather a long time should be enough)

Regards,




=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
