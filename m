Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbRAERTJ>; Fri, 5 Jan 2001 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131554AbRAERS7>; Fri, 5 Jan 2001 12:18:59 -0500
Received: from alibaba.kmit.sk ([194.160.28.1]:6151 "HELO alibaba.kmit.sk")
	by vger.kernel.org with SMTP id <S131393AbRAERSo> convert rfc822-to-8bit;
	Fri, 5 Jan 2001 12:18:44 -0500
From: Marek Gresko <gresko@kmit.sk>
Reply-To: gresko@kmit.sk
Organization: Kmit
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 TCP SYN problem
Date: Fri, 5 Jan 2001 18:16:34 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010518163400.00980@horalka.kmit.sk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every SPARC/Solaris machine completely ignores every TCP/SYN segment sourced 
from my linux 2.4.0 machine. Is it problem of kernel or missconfiguration? Or 
does Solaris something wrong?

I have used the kgcc (egcs-2.91.66) on my Red Hat 7.0 linux box for compiling 
the 2.4.0 kernel.

Problem appears also when not starting any firewall or packet scheduler.

SYN segments really reach the Solaris machine. I have used tcpdump on a 
router closest to the Solaris machine. But no response is seen. Also netstat 
on the Solaris machine doesn't report any SYN segment arrival.

When I initiate connection from Solaris machine everything goes OK. 
TCP/SYN,ACK segments are OK.

Can anyone help me?

Thanx
				Marek Gresko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
