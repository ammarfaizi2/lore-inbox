Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUJKGv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUJKGv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 02:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUJKGv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 02:51:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54150 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268303AbUJKGv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 02:51:26 -0400
Date: Mon, 11 Oct 2004 00:50:42 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: "psmouse.c: bad data from KBC: timeout" on reboot
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <001101c4af5e$a0cd4410$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On all of the 2.6 kernel versions I can remember, they all seemed to have a 
couple of strange lines flash on the screen when I rebooted just before the 
machine restarted, but the screen cleared too fast to read them. I 
eventually used my digital camera to take a video of the reboot process, and 
what's coming up is:

Please stand by while rebooting the system...
md: stopping all md devices.
md: md0 switched to read-only mode
psmouse.c: bad data from KBC - timeout
psmouse.c: bad data from KBC - timeout
Restarting system.

I don't recall seeing anything like the psmouse.c lines from 2.4 kernels. 
This machine has an Asus P4B533 motherboard and a Microsoft Wireless 
Intellimouse USB mouse (as well as Microsoft USB keyboard). There's no PS/2 
mouse connected, and I think the port is even disabled in the BIOS, but USB 
legacy is enabled so maybe that is somehow responsible? I'm currently 
running the Fedora test kernel 2.6.8-1.603 (based on 2.6.9-bk).

Anyone know what's causing this or if it's of any consequence?

