Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUEJHR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUEJHR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 03:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbUEJHR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 03:17:58 -0400
Received: from port-213-148-152-119.reverse.qsc.de ([213.148.152.119]:64079
	"EHLO mbs-software.de") by vger.kernel.org with ESMTP
	id S264542AbUEJHRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 03:17:49 -0400
Date: Mon, 10 May 2004 09:17:45 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Len Brown <len.brown@intel.com>
Cc: Bob Gill <gillb4@telusplanet.net>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
Message-ID: <20040510071745.GA4585@linux-ari.internal>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com> <1084071367.2326.62.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1084071367.2326.62.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown, Sun, May 09, 2004 04:56:07 +0200:
> Please open a bug here and attach the info,
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> or just e-mail it to me and I'll open a bug for you.

Done. It is #2665.

> Need the complete dmesg and /proc/interrupt from the most recent ACPI
> enabled kernel that worked properly -- I guess -bk6 worked okay?

yes. Also bk7 was ok.

> Any chance you can boot with "debug" and capture the console messages
> from the failure?  If no, then the complete dmesg of the latest kernel
> with "acpi=noirq" is the next best thing.

this is already attached to the bug report. I going to reboot now,
to check the bios, and set the "debug".

> #   ACPI: No IRQ known ... - using IRQ 255 (Bjarni Rúnar Einarsson)
> #   http://bugzilla.kernel.org/show_bug.cgi?id=2148
> http://linux.bkbits.net:8080/linux-2.5/gnupatch@408a06a6JHD43KPCLW3tDIYGowoxvg

compiling now.

