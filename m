Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbTE1N0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTE1N0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:26:24 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:56258 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264068AbTE1N0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:26:23 -0400
From: "William McDonald Buck" <dee@wmbuck.net>
To: <linux-kernel@vger.kernel.org>
Subject: More info on non-booting 2.5.69/2.5.70
Date: Wed, 28 May 2003 08:59:53 -0400
Message-ID: <OJEPIBLILBCOMMNBMCLLMEBGCFAA.dee@wmbuck.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed, but read everything I could find here on non-booting 2.5 kernels, and with help from list archives found and fixed my problems. 
Had the problem others have reported -- hang after unpacking the kernel, blank screen. 
Advice given here, and in "what to expect" document is to ensure one has set CONFIG_INPUT=y, CONFIG_VT=Y and CONFIG_VT_CONSOLE=Y (and sometimes says to set CONFIG_HW_CONSOLE=y). The advice does not say -- and I think should and must -- to set CONFIG_VGA_CONSOLE=y. 
This is empirical. I could not boot 2.5. I followed all suggestions, reset ACPI, set NOAPIC (which I have to do anyway with my SiS chipset) everything else suggested. No dice. Finally had to set up a serial console, and realized I needed this. 
BTW, although the new xconfig is nice, it is counter-intuitive to me that a setting under "graphics support" is essential to be able to boot (at least in my case). Maybe this is obvious to everyone else. 

Would appreciate being cc-ed on discussion since I'm not subscribed to the list.   

