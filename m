Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVATHPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVATHPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVATHPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:15:10 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:7598 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261862AbVATHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:14:53 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <F8A43C8A-6AB2-11D9-9DDC-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux Kernel list <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: serial8250_init and platform_device
Date: Thu, 20 Jan 2005 01:14:49 -0600
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont get how it is you dont have more platform_devices register than 
you should based on how serial8250_init works if you have additional 
code registering a serial8250 device.  For example, 
arch/arm/mach-s3c2410/mach-vr1000.c will register one serial8250 
device, and it appears to me that serial8250_init will register a 2nd.  
Is this the expected behavior or am I missing something?

- kumar

