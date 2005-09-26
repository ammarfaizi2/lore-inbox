Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbVIZMhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbVIZMhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVIZMhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:37:15 -0400
Received: from webmailv3.ispgateway.de ([62.67.200.115]:39389 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751408AbVIZMhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:37:14 -0400
Message-ID: <1127738224.4337eb7042903@www.domainfactory-webmail.de>
Date: Mon, 26 Sep 2005 14:37:04 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: USB on nForce4 board only working with pci=routeirq
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.143.195.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i own a nForce4 mainboard from elitegroup. It has USB 1.1 and 2.0.
If i start the computer normal with my 2.6.13 kernel i get the following:
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: OHCI Host Controller
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: USB HC takeover failed! 
(BIOS/SMM bug)
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: can't reset
Sep 25 10:12:54 discovery ACPI: PCI interrupt for device 0000:00:02.0 disabled
Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -16
Sep 25 10:12:54 discovery ohci_hcd: probe of 0000:00:02.0 failed with error -16

And non of my USB-devices is wokring anymore.
I than switched to 2.6.14-rc2-mm1, but the same behavior.
I tried to parse pci=routeirq to the kernel, and than it was wokring again.

It worked perfect, also without pci=routeirq until 25th of september.
I updated the bios, but that was one month ago, and is was using my usb
devices since then with no problems, so i don´t know, what couses this
problem now.

Kind Regards

Florian Engelhardt

PS: Please cc me, couse i am not on the list.

