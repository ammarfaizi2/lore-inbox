Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbULEDE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbULEDE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 22:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbULEDE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 22:04:27 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:63114 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261235AbULEDEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 22:04:24 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel@vger.kernel.org
Subject: Re: wakeup_pmode_return jmp failing?
In-Reply-To: <41B09C96.7090207@sun.com>
References: <41B084B4.1050402@sun.com> <41B09D4B.3090906@tmr.com> <41B09D4B.3090906@tmr.com> <41B09C96.7090207@sun.com>
Date: Sun, 5 Dec 2004 03:04:23 +0000
Message-Id: <E1CamhD-0002nh-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison <Michael.Waychison@Sun.COM> wrote:

> FWIW, my last attempts (months ago) at getting suspend to work with acpi
> on 2.4 appeared to fail the same way.  That is, when I could get the
> machine to boot properly with acpi enabled.

ACPI suspend on 2.4 certainly won't work. There's no significant amount
of support for device suspend/resume.

> Well, I'm doing this with no X, no network, no usb.  Like I said, it
> appears to suspend fine, but fails in the early wakeup code.

It would be interesting if you have any luck in tracking this down. I'm
having vaguely similar issues with another piece of hardware (S3 works
fine on my Thinkpad), though it seems to reboot before any 16 bit code
is run. http://bugzilla.kernel.org/show_bug.cgi?id=3691 is the bugzilla
entry for that one.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
