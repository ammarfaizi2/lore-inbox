Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbSJSRj4>; Sat, 19 Oct 2002 13:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSJSRjz>; Sat, 19 Oct 2002 13:39:55 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26887 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265641AbSJSRjy>; Sat, 19 Oct 2002 13:39:54 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.5.43 smp bootup crash, more info - probably scsi/raid
Date: 19 Oct 2002 17:45:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <aos5o9$rt8$1@gatekeeper.tmr.com>
References: <3DAE605F.3B744FFC@broadpark.no> <3DAE8E90.D3E7CACF@aitel.hist.no>
X-Trace: gatekeeper.tmr.com 1035049545 28584 192.168.12.62 (19 Oct 2002 17:45:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DAE8E90.D3E7CACF@aitel.hist.no>,
Helge Hafting  <helgehaf@aitel.hist.no> wrote:
| Helge Hafting wrote:
| 
| > It produced a backtrace so long that most of it
| > scrolled off the screen, before stating that
| > it didn't sync in an interrupt handler.
| >
| Some of the functions in the trace was scsi stuff.
| I have a tekram scsi controller, driven by
| "SYM53C8XX Version 2 SCSI support"
| 
| The crash happens immediately after initializing
| the controller and discovering the two
| disks.  This is where autodetection
| of RAID usually happens.
| So it seems to me that it is either some
| scsi problem, or a RAID problem.
| 
| The problem affects both 2.5.43 and 2.5.43-mm2.

Is it an OOPS or just a BUG? I got a BUG until I applied the patch, now
my SCSI devices don't actually work, but I don't get an OOPS.

See my other post on the patch, or write my off-list if you can't find it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
