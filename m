Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266465AbRGCH0y>; Tue, 3 Jul 2001 03:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266462AbRGCH0o>; Tue, 3 Jul 2001 03:26:44 -0400
Received: from [164.164.82.29] ([164.164.82.29]:6387 "EHLO subexgroup.com")
	by vger.kernel.org with ESMTP id <S266465AbRGCH0a>;
	Tue, 3 Jul 2001 03:26:30 -0400
From: "Anil Kumar" <anilk@subexgroup.com>
To: <kiran.thirumalai@in.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Validation of memory allocated through kmalloc
Date: Tue, 3 Jul 2001 13:12:42 +0530
Message-ID: <NEBBIIKAMMOCGCPMPBJOAEDMCHAA.anilk@subexgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010610144501.A14342@localhost.in.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
X-Return-Path: anilk@subexgroup.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use sys_mprotect(...)  to verify the validity of the returned address.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
kiran.thirumalai@in.ibm.com
Sent: Sunday, June 10, 2001 2:45 PM
To: linux-kernel@vger.kernel.org
Subject: Validation of memory allocated through kmalloc


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


DISCLAIMER: This correspondence is confidential and intended for the named
recipient(s) only. If you are not the named recipient and receive this
correspondence in error, you must not copy, distribute or take any action in
reliance on it and you should delete it from your system and notify the
sender immediately. Unless otherwise stated, any views or opinions expressed
are solely those of the author and do not represent those of Subex Systems
Limited.


