Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJEUss>; Fri, 5 Oct 2001 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273135AbRJEUsi>; Fri, 5 Oct 2001 16:48:38 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:36568 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S273065AbRJEUsU>; Fri, 5 Oct 2001 16:48:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 5 Oct 2001 13:48:42 -0700
Message-Id: <200110052048.NAA19993@baldur.yggdrasil.com>
To: jamey.hicks@compaq.com, linux-kernel@vger.kernel.org
Subject: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Attempting to compile linux-2.4.11-pre4/drivers/mtd/bootldr.c
fails with a bunch of compiler errors, including a complaint that
"struct tag" is not defined anywhere.  Presumably this is the result
of an incompletely applied patch.

	Reverting drivers/mtd/bootldr.c to the linux-2.4.11-pre3
version makes it compile without problems.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
