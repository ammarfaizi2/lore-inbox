Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbTLFW3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265262AbTLFW3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:29:23 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:12929
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265255AbTLFW3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:29:22 -0500
Date: Sat, 6 Dec 2003 17:26:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Markku Savela <msa@burp.tkv.asdf.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
In-Reply-To: <3FD2566D.9020305@wmich.edu>
Message-ID: <Pine.LNX.4.58.0312061725360.1758@montezuma.fsmlabs.com>
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org>
 <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
 <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org> <200312061652.59880.dtor_core@ameritech.net>
 <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com> <3FD2566D.9020305@wmich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Ed Sweetman wrote:

> It took over 3 days to trigger it on my system, so booting to  single
> user mode and waiting 5 minutes is not a good marker of deciding if
> that's the case or not.  Also, i dont have SCSI compiled in my kernel at
> all yet this happens. So that idea is out.

Not SCSI but SCI (System Control Interrupt)

> Here is my /proc/interrupts
>             CPU0
>    0:  426319022          XT-PIC  timer
>    1:     409358          XT-PIC  i8042
>    2:          0          XT-PIC  cascade
>    5:          0          XT-PIC  acpi

That would be irq5
