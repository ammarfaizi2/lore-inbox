Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132445AbQLNKwZ>; Thu, 14 Dec 2000 05:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132025AbQLNKwQ>; Thu, 14 Dec 2000 05:52:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14352 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132445AbQLNKwE>; Thu, 14 Dec 2000 05:52:04 -0500
Subject: Re: do NOT compile 2.2.18 with egcs-1.1.2
To: dmircea@linux.kappa.ro (Mircea Damian)
Date: Thu, 14 Dec 2000 10:23:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001214102145.B17934@linux.kappa.ro> from "Mircea Damian" at Dec 14, 2000 10:21:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146VXg-00045d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just want to let other know that kernel 2.2.18 does not work properly (*)
> on my box if I compile it with egcs-2.91.66 19990314/Linux (egcs-1.1.2
> release). Instead gcc-2.7.2.3 works ok.
> 
> (*) the network driver PCI NE2000 does not work with all three cards. It
> just sees them but they do not work.

I don't believe that is likely to be the reason. The driver has not changed
since 2.2.15 if not earlier, and it still seems to work with the cards I have
here (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
