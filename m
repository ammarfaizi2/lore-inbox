Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbRFKGjV>; Mon, 11 Jun 2001 02:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263444AbRFKGjK>; Mon, 11 Jun 2001 02:39:10 -0400
Received: from [164.164.82.20] ([164.164.82.20]:56050 "EHLO subexgroup.com")
	by vger.kernel.org with ESMTP id <S263442AbRFKGjD>;
	Mon, 11 Jun 2001 02:39:03 -0400
From: "Anil Kumar" <anilk@subexgroup.com>
To: <kiran.thirumalai@in.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: RE:
Date: Mon, 11 Jun 2001 12:24:25 +0530
Message-ID: <NEBBIIKAMMOCGCPMPBJOKEAFCFAA.anilk@subexgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <CA256A68.001C53EA.00@d73mta01.au.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
X-Return-Path: anilk@subexgroup.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can use "sys_mprotect" call which is kernel space equ. of "mprotect" .
The implementation for the same can be found in "mm\mprotect.c".

anil

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
kiran.thirumalai@in.ibm.com
Sent: Monday, June 11, 2001 10:29 AM
To: linux-kernel@vger.kernel.org
Subject:


Hi,
Is there some kernel api to validate memory allocated using kmalloc.
Suppose, I allocate some memory using kmalloc and at a later point of
execution
I would like to validate if the memory allocated is not possibly freed by
some other thread.

Pls suggest a patch/pointers if any.
I also noticed a commented 'CONFIG_DEBUG_MALLOC' config option  (2.4.3
source),
It doesn't seem to be functional.  Any pointers towards the history behind
it would also be helpful.

Thanks in advance,
Kiran




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


