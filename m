Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSAEXkM>; Sat, 5 Jan 2002 18:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286422AbSAEXkC>; Sat, 5 Jan 2002 18:40:02 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:42626 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S286447AbSAEXjl>; Sat, 5 Jan 2002 18:39:41 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 5 Jan 2002 15:39:38 -0800
Message-Id: <200201052339.PAA00441@baldur.yggdrasil.com>
To: zaitcev@redhat.com
Subject: Re: Patch: linux-2.5.2-pre8/drivers/sound compilation fixes: MINOR-->minor
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Pete Zaitcev <zaitcev@redhat.com>

>> 	Doing a global replace of "MINOR(" with "minor(" in all
>> .c files in linux/drivers/sound allows all of the sound drivers
>> to compile (at least as modules on x86).  [...]

>You did not change ymfpci, why? Linus fixed it already?

	linux-2.5.2-pre8/drivers/sound/ymfpci.c compiles without
errors or warnings, unmodified.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
