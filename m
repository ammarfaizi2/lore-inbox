Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271655AbTGRAUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271656AbTGRAUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:20:41 -0400
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:23034 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S271655AbTGRAUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:20:39 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 insmod question
Date: Thu, 17 Jul 2003 18:35:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I completed a fibre channel driver change to support for 2.5.72 (suppose to be 2.6 compatible) and compiled it OK.  When trying load the driver with "insmod", it complains with the message "insmod: QM_MODULES: Function not implemented".

I tried kernel built module qla1280.o and got the same result.  It seems the insmod utility in my system is not compatible with new 2.5.72 built module.

I have 2.4.20-8 kernel installed first and driver loads and runs fine.  Later added 2.5.72 kernel and booted with its bzImage works fine too.  However, the insmod utility I am using to load new driver was from 2.4.20-8 which has system_query_module() being called.  I checked Doc. and source code for 2.5.72 and could not find same function call in module.c

Some web documents mentioned that the module installation is changed from 2.4.x to 2.5.x.  So far I am still looking for the solution and hope someone can help me on the issue.

I am compiling the driver out side of kernel source tree but using kernel environmental variables for compatibility.

Regards,

Eddie

 

