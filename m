Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTLBXVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTLBXVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:21:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58888 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264445AbTLBXVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:21:36 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: IDE-SCSI oops in 2.6.0-test11
Date: 2 Dec 2003 23:10:27 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqj653$e18$1@gatekeeper.tmr.com>
References: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com> <1070401986.12502.6.camel@athlonxp.bradney.info>
X-Trace: gatekeeper.tmr.com 1070406627 14376 192.168.12.62 (2 Dec 2003 23:10:27 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1070401986.12502.6.camel@athlonxp.bradney.info>,
Craig Bradney  <cbradney@zip.com.au> wrote:
| Just as an fyi, Im on a 2600, same mobo (well, v2 1007 bios).. 2.6 test
| 11, acpi on, local apic on, apic on.
| 
| Can burn CDs and DVD+RWs without IDE-SCSI just fine.

I bet you're using a recent cdrecord and growisofs, both of which have
had Linux-specific code added to use the non-SCSI interface. Programs
which are written for SCSI won't run on that interface.

I'm told that SCSI programs for Win9x will run under vmware using
ide-scsi under 2.4 but not 2.6, can someone confirm? I don't have the
software for that test, but I'm told Win9x is quite popular ;-)

The last time I tried cdparanoia it didn't work with 2.6 (ATAPI or
ide-scsi), and I haven't tried cdda2wav. Some work, some don't.

Please let us know if you're using other software than my guess, hard to
track what's been converted from SCSI to ATAPI.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
