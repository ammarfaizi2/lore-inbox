Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265319AbVBFFSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbVBFFSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbVBFFSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:18:24 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:26785 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S272799AbVBFFRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:17:48 -0500
Subject: 2.6: USB Storage hangs machine on bootup for ~2 minutes
From: Parag Warudkar <kernel-stuff@comcast.net>
To: USB development list <linux-usb-devel@lists.sourceforge.net>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0502041539350.674-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0502041539350.674-100000@ida.rowland.org>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 00:18:00 -0500
Message-Id: <1107667080.4089.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running FC3 on a AMD64 laptop. The laptop has 3 USB ports. If I
attach any usb-storage device (Sandisk Cruiser usb drive, iPod, Maxtor
external drive etc.) the kernel hangs while booting. The hang occurs
shortly after the usb-storage module is loaded. The machine does not
respond to anything other than the power button. This hang lasts for
about 2 minutes after which boot resumes and goes on fine. 

When it is hung, the usb storage devices are not being accessed - the
iPOD for e.g does not show the Do not Disconnect sign when it is hung -
it shows that after the boot resumes. Might have something to do with
the recent "Waiting for device to settle" change in usb-storage?


A 

The boot goes on without a hang if there are no usb-storage devices
attached to the system. (USB mouse is fine for example, so the hang
happens only in case of usb-storage devices.)

PS - This bug was also reported to Redhat Bugzilla some time ago - I
haven't got any feedback so far.

Parag



