Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTKZRlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTKZRlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:41:11 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:647 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264266AbTKZRlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:41:06 -0500
Subject: Can't boot Acer 240 Laptop
From: Danny Brow <fms@istop.com>
To: Kernel-Maillist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1069868377.23018.11.camel@zeus.fullmotionsolutions.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 12:39:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to compile the 2.4.23-pre9 and 2.4.23-rc4 both will not
boot this laptop.

Laptop details
intel 2.5 celeron
256 MB RAM
852GME Chipset
Slackware (if this really matters)

What I have done.
Compiled kernel 2.4.23-pre9, from fresh source. 

First try:
Intel P4 support, defaults for mostly everything, ACPI,  APM, FB,
ide-scsi, 8139too, and ICH sound.

2nd
Everything above but changed CPU to P3.
No boot (also tried with the acpi=off option in lilo.)


3rd.
rm kernel source, fresh source with 2.4.23-rc4 patch.  P4, ACPI, APM,
FB, ide-scsi, ich sound.
Same problem.

4th
Same as above but removed FB support.
No boot again.

5th
p3, no acpi, apm, no FB, ide-scsi.
Same problem.

As you can see I can't figure this out for the life of me.  I am trying
2.4.23-pre4 with out SMP.  Maybe that will work.

TIA

Dan.



