Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQLTP0g>; Wed, 20 Dec 2000 10:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQLTP00>; Wed, 20 Dec 2000 10:26:26 -0500
Received: from [200.43.18.234] ([200.43.18.234]:57100 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S129784AbQLTP0Q>; Wed, 20 Dec 2000 10:26:16 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Weird vmstat reports in 2.2.18
Message-ID: <977324137.3a40c869a394e@webmail.telpin.com.ar>
Date: Wed, 20 Dec 2000 11:55:37 -0300 (ARST)
From: albertogli@telpin.com.ar
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some strange reports with vmstat on a dual iPPro running 2.2.18,
it doesnt happen very frequently, but i see it a lot when compiling something 
(kernel and mysql specially, not when compiling small stuff), though it doesnt 
look like a high-load issue. When the machine is idle (ie. most of the time at 
the moment) it doesnt show up.

The report is like this:
#vmstat 1 60 | awk '{ print $16 }'
id
0
0
20452224
1
20452224
0
1
20452224
1
0
0

I wasnt able to trigger it in a predictable way, it just pops up...
BUT if i open two vmstats in different consoles.. the number doesnt show up in 
both, just in one of them... so i'm not sure at all if this is a kernel bug, or 
just another (vmstat?) feature =)
I also found a reference to something similar in 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0009.3/0273.html

       Alberto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
