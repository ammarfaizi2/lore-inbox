Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVFILQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVFILQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVFILQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:16:00 -0400
Received: from [202.125.86.130] ([202.125.86.130]:47840 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262348AbVFILPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:15:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: ld: cannot open pad.o COMPILE Error --help
Date: Thu, 9 Jun 2005 16:53:48 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811543210@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ld: cannot open pad.o COMPILE Error --help
Thread-Index: AcVs4rZtwefwfFtvSHGzSPSbYvR8Vg==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
 
I am written a new keypad driver `keypad_drv.c' .I wanted this to be integrated to the kernel rather than a module.
 
So, I edited the Config.in file the driver/char adding
 
        bool `EP93xx Keypad support' CONFIG_GPIO_KEYPAD
 
I edited the Makefile file in driver/char adding
 
        Obj-$(CONFIG_GPIO_KEYPAD) +=keypad_drv.o
 
Is there any thing that I am missing just because, I am not able to compile and I am getting the following Error:
 
        arm-linux-ld: cannot open keypad_drv.o: No such file or directory
 
Can any one suggest me what is the problem?
 
 
Regards,
Mukund Jampala
 
 

