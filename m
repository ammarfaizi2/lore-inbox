Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUIGVVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUIGVVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUIGVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:07:59 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:15942 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268641AbUIGVEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:04:25 -0400
Subject: Re: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
From: Paul Fulghum <paulkf@microgate.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1094591061.2531.8.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Sep 2004 16:04:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 15:03, Bjorn Helgaas wrote:
> Thanks for the report.  Figures that it would be an HP machine ;-)
> Can you apply the following patch on top of 2.6.9-rc1-mm4, boot
> with "i8042.lsacpi", and post the resulting dmesg?

Nothing is output with i8042.lsacpi=1.
I tried it with both i8042.noacpi=1 and 0.

I did notice the following:

Sep  7 15:53:57 deimos kernel: ACPI: Unable to locate RSDP
<snip>...
Sep  7 15:53:58 deimos kernel: ACPI: Subsystem revision 20040816
Sep  7 15:53:58 deimos kernel: ACPI: Interpreter disabled.

 
--
Paul Fulghum
paulkf@microgate.com


