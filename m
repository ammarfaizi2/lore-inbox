Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTLBXbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTLBXbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:31:00 -0500
Received: from legolas.restena.lu ([158.64.1.34]:14302 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264434AbTLBXaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:30:55 -0500
Subject: Re: IDE-SCSI oops in 2.6.0-test11
From: Craig Bradney <cbradney@zip.com.au>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312022310.SAA14384@gatekeeper.tmr.com>
References: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com>
	 <1070401986.12502.6.camel@athlonxp.bradney.info>
	 <200312022310.SAA14384@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1070407849.12502.17.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 00:30:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 00:10, bill davidsen wrote:
> In article <1070401986.12502.6.camel@athlonxp.bradney.info>,
> Craig Bradney  <cbradney@zip.com.au> wrote:
> | Just as an fyi, Im on a 2600, same mobo (well, v2 1007 bios).. 2.6 test
> | 11, acpi on, local apic on, apic on.
> | 
> | Can burn CDs and DVD+RWs without IDE-SCSI just fine.
> 
> I bet you're using a recent cdrecord and growisofs, both of which have
> had Linux-specific code added to use the non-SCSI interface. Programs
> which are written for SCSI won't run on that interface.

Sorry.. missed those out:
k3b 0.10.2
cdrdao 1.1.8pre2
cdrtools 2.01 alpha 19 (cdrecord is in here.. it is 2.01a19-dvd)
and growisofs is 5.1.3
mkisofs is 2.01a17.

All are latest "usntable" builds on Gentoo, or cvs. So, yes.. very
recent. I was very happy when i could burn a CD/DVD without IDE-SCSI,
and that was part of the reason I tried out 2.6 now.

> I'm told that SCSI programs for Win9x will run under vmware using
> ide-scsi under 2.4 but not 2.6, can someone confirm? I don't have the
> software for that test, but I'm told Win9x is quite popular ;-)

> 
> The last time I tried cdparanoia it didn't work with 2.6 (ATAPI or
> ide-scsi), and I haven't tried cdda2wav. Some work, some don't.

cdparanoia: 9.8 (march 23 2001)
cdda2wav 2.01a19
> 
> Please let us know if you're using other software than my guess, hard to
> track what's been converted from SCSI to ATAPI.

Let me know if you want anymore versions.

Craig

