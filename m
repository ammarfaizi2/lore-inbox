Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275815AbRI1D1z>; Thu, 27 Sep 2001 23:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275814AbRI1D1p>; Thu, 27 Sep 2001 23:27:45 -0400
Received: from [64.225.255.11] ([64.225.255.11]:14543 "EHLO
	imta02a2.registeredsite.com") by vger.kernel.org with ESMTP
	id <S275812AbRI1D13>; Thu, 27 Sep 2001 23:27:29 -0400
Message-Id: <4.3.2.7.2.20010927233132.00b75ee0@pop.registeredsite.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 27 Sep 2001 23:31:55 -0400
To: Alex Cruise <acruise@infowave.com>, "'Randy.Dunlap'" <rddunlap@osdlab.org>
From: "Lewin A.R.W. Edwards" <larwe@larwe.com>
Subject: RE: apm suspend broken in 2.4.10
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B2@earth.infowave.co
 m>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Sep 27 19:39:09 onus kernel: awc: APM Suspend vetoed by:
>Sep 27 19:39:09 onus kernel:   type = 1 id = 1104151299 callback =
>-1072064644 data = 0 flags = 0 state = 0 prev_state = 0
>
>1104151299 is 0x41D00303, which if you consult your include/linux/pm.h
>(PM_SYS_DEV = 1, PM_SYS_KBC = 0x41d00303), would seem AFAICT to indicate
>that it's the keyboard driver--or something upstream of it--who's vetoing my
>suspend.  Am I crazy?

Maybe something to do with A20 switching?


-- Lewin A.R.W. Edwards
Embedded Engineer, Digi-Frame Inc.
Work: http://www.digi-frame.com/
Tel (914) 937-4090 9am-6:30pm M-F ET
Personal: http://www.larwe.com/ http://www.zws.com/


