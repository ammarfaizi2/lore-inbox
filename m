Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVGSKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVGSKgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGSKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:36:15 -0400
Received: from [64.34.38.30] ([64.34.38.30]:36839 "EHLO mercury.illhostit.com")
	by vger.kernel.org with ESMTP id S261949AbVGSKgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:36:13 -0400
From: "John Pearson" <john@illhostit.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Problems with reboot/poweroff on SMP machine
Date: Tue, 19 Jul 2005 03:41:51 -0700
Message-ID: <JCEEICIEKCENOEGFMGBAGEAECAAA.john@illhostit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <dnwtnn3yza.fsf@magla.zg.iskon.hr>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mercury.illhostit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - illhostit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately my Dual Xeon server has not been rebooting properly either. When I
tell it to reboot I end up having to call the datacenter and tell them to
powercycle it because after 10 minutes it wasn't back up. If you need any
details, please provide instructions for giving them to you.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Zlatko Calusic
Sent: Tuesday, July 19, 2005 2:52 AM
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: Problems with reboot/poweroff on SMP machine


Hi Eric and all!

Last few weeks or so I started having problems with reboot/poweroff on
my aging SMP desktop (dual PIII, Apollo Pro 266 chipset). The machine
does all steps til' the very end where it stops (hangs) before the
actual reboot or poweroff. The problem doesn't happen every time (but
occasionally). Alt-SysRQ-B/O doesn't work at the point of hang.

I did a little bit of investigation and I believe that this patch:


http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
tdiff;h=dd2a13054ffc25783a74afb5e4a0f2115e45f9cd

is the primary suspect for the regression (reboots and poweroffs have
been working fine for the last few years on this particular
machine). But now I need expert help. :) I'm willing to help decipher
this, so don't hesitate to ask for more details! I don't even know
what info is useful to provide at this point (kernel is virgin 2.6.12,
ACPI is compiled in, I don't use any boot time reboot= parameter, what
else?). And please Cc: me 'cause I'm not on the list.

Thanks for any info!
--
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

