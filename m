Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFOAus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFOAus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFOAus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:50:48 -0400
Received: from smtp-auth.no-ip.com ([8.4.112.95]:3560 "HELO
	smtp-auth.no-ip.com") by vger.kernel.org with SMTP id S261454AbVFOAun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:50:43 -0400
From: dagit@codersbase.com
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
	<87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz>
	<87oea860rl.fsf@www.codersbase.com> <20050614231115.GE2172@elf.ucw.cz>
	<87ekb45u5a.fsf@www.codersbase.com>
Organization: Coders' Base
Date: Tue, 14 Jun 2005 17:50:41 -0700
In-Reply-To: <87ekb45u5a.fsf@www.codersbase.com> (dagit@codersbase.com's
 message of "Tue, 14 Jun 2005 17:41:05 -0700")
Message-ID: <87acls5tpa.fsf@www.codersbase.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-REPORT-SPAM-TO: abuse@no-ip.com
X-NO-IP: codersbase.com@noip-smtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for check about the push alone causing the reboot, I removed the
> pop, and it still reboots, but to me that doesn't say that it's the
> push that does it.  It could be the next line.  I'll try to put in an
> infinite loop.

I added a loop "jmp ." right after the pushl and the machine still
reboots.  So the pushl does cause the reboot.

Hopefully, you can show me how to move the stack and I will try that
as well.

Thanks,
Jason

