Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTB0JhU>; Thu, 27 Feb 2003 04:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTB0JhU>; Thu, 27 Feb 2003 04:37:20 -0500
Received: from ims21.stu.nus.edu.sg ([137.132.14.228]:39455 "EHLO
	ims21.stu.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S262469AbTB0JhS> convert rfc822-to-8bit; Thu, 27 Feb 2003 04:37:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Param-oldstyle.patch
Date: Thu, 27 Feb 2003 17:47:22 +0800
Message-ID: <720FB032F37C0D45A11085D881B03368A2B32C@MBXSRV24.stu.nus.edu.sg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Param-oldstyle.patch
Thread-Index: AcLeRTkpHRXIzg1HQUqZIKBL3dtKYQ==
From: "Eng Se-Hsieng" <g0202512@nus.edu.sg>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2003 09:47:22.0650 (UTC) FILETIME=[39F89FA0:01C2DE45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I receive the following error message while compiling an 'old-style'
driver in 2.5.59:
'MOD_IN_USE': undeclared function

However, when applying 'param-oldstyle.patch.gz' to support old-style
"MODULE_PARM" declarations, I get

Patching file include/linux/module.h
Reversed (or previously applied) patch detected! Assume -R? [n]

I think that if the patch had already been applied, I should get an
option: 
[]config OBSOLETE_MODPARM 

But my current kernel configuration looks like this and I can't find
[]config OBSOLETE_MODPARM anywhere:

[Y]Enable loadable module support
	[Y] Module unloading
		[]Forced module unloading
	[Y] Kernel module loader

I would be grateful for any advice on how to successfully apply the
patch and compile this device driver for 2.5.59.

Thank you.

Regards,
Se-Hsieng


