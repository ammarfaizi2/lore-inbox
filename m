Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTDVN03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTDVN02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:26:28 -0400
Received: from customer204.globaltap.com ([206.104.238.204]:5839 "HELO
	annexa.net") by vger.kernel.org with SMTP id S263162AbTDVN0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:26:24 -0400
Subject: Need help with lockups on tyan s2460 motherboard in SMP mode
From: James Strandboge <jamie@tpptraining.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Targeted Performance Partners, LLC
Message-Id: <1051018709.3235.55.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2003 09:38:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have googled a lot on this issue, but if there is somewhere else I can
look, please tell me.

I have a dual AMD 1600+ (MP processors) system with tyan s2460
motherboard that freezes with no error messages in syslog.  I have read
(among a lot of other things):
http://ouray.cudenver.edu/~etumenba/smp-howto/SMP-HOWTO.html

and what I have done so far is:

replaced power supply with Enermax 550
BIOS upgrade to 1.05
kernels used are 2.4.18 from debian, 2.4.20 and 2.4.21-pre6 
compiled in acpi (acpi-200303028-2.4.21-pre6)
compiled out acpi
compiled with and without Athlon support
Currently using 2.4.21-pre6 for i386

booted with combinations of the following:
noapic
noacpi
acpi=off
nopentium

tried the following bios settings in various combinations:
MultiProcessor specification 1.1 and 1.4
Use PCI Interrupt Entries in MP as yes and no
enabled/disabled acpi
enabled/disabled power management

The only way I have found to reliably crash the system is to compile two
kernels simultaneously while in smp mode.  If I boot with 'nosmp' the
system seems ok (still running and compiling after 9 hours).

Because the system runs ok with one processor, it leads me to think it
may be kernel code, and not heat or memory related.  Though I guess it
could be the motherboard still.  Is this a correct assessment?  I'd be
happy to send any additional information.

I am new to SMP, so any and all suggestions are welcome.

Thanks,

Jamie Strandboge

-- 
James Strandboge
Targeted Performance Partners, LLC
Web: http://www.tpptraining.com
E-mail: jamie@tpptraining.com
Tel: (585) 271-8370
Fax: (585) 271-8373

