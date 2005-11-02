Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVKBCvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKBCvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVKBCvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:51:21 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:9664
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932230AbVKBCvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:51:20 -0500
Message-ID: <436837B2.6020408@linuxwireless.org>
Date: Tue, 01 Nov 2005 20:51:14 -0700
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: ACPI Errors, battery info is lost.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I have an IBM T42 Debian Sid, with latest BIOS and correct options 
(had old BIOS before and still same problem) Sometimes, when I'm running 
on Battery power, I get this problem, it might also occur when charging 
the battery.

I had opened a bug about it in bugzilla, but I never got an answer. I 
provided the acpidump and so on.

This so far with 2.6.13 and 2.6.14 dunno if also with older kernels.

Nov  1 19:27:12 localhost kernel:     ACPI-0292: *** Error: Looking up 
[SERN] in namespace, AE_ALREADY_EXISTS
Nov  1 19:27:12 localhost kernel:     ACPI-0508: *** Error: Method 
execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c14cd600), 
AE_ALREADY_EXISTS
Nov  1 19:27:14 localhost kernel:     ACPI-0213: *** Error: Method 
reached maximum reentrancy limit (255)
Nov  1 19:27:14 localhost kernel:     ACPI-0508: *** Error: Method 
execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), 
AE_AML_METHOD_LIMIT
Nov  1 19:27:16 localhost kernel:     ACPI-0213: *** Error: Method 
reached maximum reentrancy limit (255)


.Alejandro
