Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313430AbSC2Kee>; Fri, 29 Mar 2002 05:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313431AbSC2KeY>; Fri, 29 Mar 2002 05:34:24 -0500
Received: from smtp03.vsnl.net ([203.197.12.9]:40675 "EHLO smtp03.vsnl.net")
	by vger.kernel.org with ESMTP id <S313430AbSC2KeI>;
	Fri, 29 Mar 2002 05:34:08 -0500
Message-ID: <3CA44288.EF27E043@vsnl.net>
Date: Fri, 29 Mar 2002 16:01:36 +0530
From: "Amit S. Kale" <kgdb@vsnl.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: announce: kgdb 1.5 with reworked buggy smp handling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kgdb 1.5 at http://kgdb.sourceforge.net/

smp handling is completely reworked. Previous kgdb had a bug
which caused it to hang when a processor spun with
interrupts disabled and another processor enters kgdb. kgdb
now uses nmi watchdog for holding other processors while
a machine is in kgdb. 
-- 
Amit S. Kale
Linux kernel source level debugger    http://kgdb.sourceforge.net/
	[29th March - kgdb-1.5 with reworked smp handling.]
Translation filesystem                http://trfs.sourceforge.net/

