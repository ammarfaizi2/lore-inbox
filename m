Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGSnH>; Thu, 7 Dec 2000 13:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbQLGSnD>; Thu, 7 Dec 2000 13:43:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54539 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129226AbQLGSmy>;
	Thu, 7 Dec 2000 13:42:54 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012071812.VAA31620@ms2.inr.ac.ru>
Subject: Re: Out of socket memory? (2.4.0-test11)
To: zwwe@opti.cgi.NET (Daniel Walton)
Date: Thu, 7 Dec 2000 21:12:08 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20001206223822.03997008@209.54.94.12> from "Daniel Walton" at Dec 7, 0 08:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> What am I doing wrong?

You change parameters without investigating why failure happened.
This approach cannot succeed, of course.


> problem?  Is there any way I can get runtime information from the kernel on 
> things like amount of socket memory used and amount available?

cat /proc/net/sockstat
cat /proc/net/netstat
cat /proc/net/snmp
cat /proc/slabinfo
cat /proc/net/tcp

Next time when you will see these messages, do this, pack the result
and send to me pointopoint.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
