Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTBINLk>; Sun, 9 Feb 2003 08:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbTBINLj>; Sun, 9 Feb 2003 08:11:39 -0500
Received: from web41413.mail.yahoo.com ([66.218.93.79]:14489 "HELO
	web41413.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267242AbTBINLh>; Sun, 9 Feb 2003 08:11:37 -0500
Message-ID: <20030209132115.84086.qmail@web41413.mail.yahoo.com>
Date: Mon, 10 Feb 2003 00:21:15 +1100 (EST)
From: =?iso-8859-1?q?Con=20Kolivas?= <ckolivas@yahoo.com.au>
Subject: 2.4.20-ck3
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated my patchset

http://members.optusnet.com.au/ckolivas/kernel/

It includes:

O(1) Batch scheduler
Preemptible
Low Latency
AA Virtual Memory additions
or
RMAP15d VM
Read Latency2
Supermount
XFS1.2pre5
ACPI
Desktop Tuning
optional compressed caching

Split out patches are available.

Changes:
small O(1) bugfixes
updated rmap option
Updated supermount
Updated xfs file system
Desktop tuning now has smaller timeslices across the
board, with altered tuning of the O(1) scheduler.

Removed:
Alsa - the aging 0.90rc2 patches. Just take the
sources from alsa-project.org, add water and compile
after your kernel is cooked
Variable timeslice - Smaller timeslices across the
board achieve a similar effect without added code

Please test carefully, especially those using xfs as
this code I have not tested extensively.

Address to find this is:

http://members.optusnet.com.au/ckolivas/kernel/

Till my domain is alive again.

Contact me on this email address for any
correspondence  till further notice.

Benchmarks will follow shortly

Con


http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your seasons greetings online this year!
