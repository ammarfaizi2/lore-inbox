Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTLBVua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTLBVua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:50:30 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41736 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263861AbTLBVuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:50:24 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: IDE-SCSI oops in 2.6.0-test11
Date: 2 Dec 2003 21:39:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqj0q3$dge$1@gatekeeper.tmr.com>
References: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com> <3FCC9307.8050409@wmich.edu>
X-Trace: gatekeeper.tmr.com 1070401155 13838 192.168.12.62 (2 Dec 2003 21:39:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FCC9307.8050409@wmich.edu>,
Ed Sweetman  <ed.sweetman@wmich.edu> wrote:
| ross.alexander@uk.neceur.com wrote:
| > CPU: Athlon-XP 2700+
| > MB: ASUS A7N8X Deluxe
| > Memory: 3 x 512MB
| > Notes: UP kernel, standard EIDE driver, boot paramters acpi=off 
| > nolapic,noapic
| > Libc: glibc-2.3.2 with linuxthreads.
| > 
| > This error occurs while trying to write a DVD+RW to an NEC-1300A DVD 
| > writer
| > using cdrecord-dvdpro executable (no source available).  This works fine
| > on linux-2.4.23.
| > 
| 
| 
| 
| First off, acpi should be working just fine now...should have been for 
| the last couple versions of 2.6.0-test.

Is that "should have been working" as in "I believe it to be working" or
"dammit they said it was working?"

| Second, you probably shouldn't be using ide-scsi.  ATAPI works just fine 
| using straight ide for CDR's so it probably works fine for DVD-R+R+RW 
| whatever stupid acronymn they're using today.

ATAPI works fine for programs which know about it and are
Linux-specific. Programs expecting SCSI devices, which work on Linux
2.4, Solaris, SCO, and even Windows (I'm told) want SCSI.

| Third, you didn't post the actual oops so how is anyone supposed t osay 
| anything about this problem?

Your mail was truncated, I believe.

| Fourth, you are using a binary you didn't compile that's probably 
| compiled against headers for api's found in 2.4.x which is seriously 
| different from the kernel you're running it on. Compile your own 
| cdrecord and see how it goes.

You missed the "binary only" in his post. That software is no more
available in source than Windows.

I think the real point is not that it doesn't work, but that it oops's
the system. I would regard anything which a user can do which causes an
oops as a critical problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
