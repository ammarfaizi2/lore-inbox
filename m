Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTBDVqM>; Tue, 4 Feb 2003 16:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBDVqM>; Tue, 4 Feb 2003 16:46:12 -0500
Received: from dhcp065-024-013-119.columbus.rr.com ([65.24.13.119]:33184 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id <S267423AbTBDVqL>; Tue, 4 Feb 2003 16:46:11 -0500
Date: Tue, 4 Feb 2003 16:53:58 -0500
From: David Brown <dave@codewhore.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CCISS driver and disk failure...
Message-ID: <20030204215358.GA6266@codewhore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Does anyone know of an easy way to get messages (via syslog or
otherwise) when a member disk of a CCISS SMART-2 raid array fails?
Grepping through drivers/block/cciss.c didn't yield any obvious
printk's. My gut feeling is that one could get the disk failure
information through one of the CCISS_PASSTHRU ioctls(); I saw some
reference to a similar call in code for monitoring the cpqarray
driver.

HP appears to have some sort of management suite, but it appears to
require X11 server-side, which isn't an option on this machine.

Is there an easy way to get disk failure information from the CCISS
driver, or should I continue relying on the pretty LEDs? :)


Thanks in advance,

- Dave

