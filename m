Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130364AbQKTUMk>; Mon, 20 Nov 2000 15:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbQKTUMX>; Mon, 20 Nov 2000 15:12:23 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:46263 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129831AbQKTULr>; Mon, 20 Nov 2000 15:11:47 -0500
Message-ID: <3A197E1A.A936D847@neurontech.fr>
Date: Mon, 20 Nov 2000 20:40:10 +0100
From: Vincent Marty <jvmarty@neurontech.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Vincent Marty <vmarty@neurontech.fr>,
        Dominique Gence <dgence@neurontech.fr>
Subject: Dual Via694 M/B locks during 2.4.0-test11 boot. APIC pb ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am using a Gigabyte 6VXDC7 Dual Pentium III MB.
This motherboard uses a Via 694 chipset. cf
http://www.giga-byte.com/products/6vxdc7.htm

With the 2.4.0-test11-pre1 kernel the system freezes during boot. I
suspect APIC pbs.

Can anybody help me ?
Thanks. Vincent

Below is the content of the screen when 2.4.0-test11-pre1 freezes during
boot.

Getting VERSION : 40011
Getting VERSION : 40011
Getting ID : 0
Getting ID : f000000
Getting LVT0 : 700
Getting LVT1 : 400
enabled ExtINT on CPU#0
ESR value before enabling vector : 00000084
ESR value after enabling vector : 00000000
CPU present map : 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector
1
2
3
Asserting INIT
Waiting for send to finish...
+ Deasserting INIT.
Waiting for send to finish...
+# startup loops : 2
Sending STARTUP #1.
After apic_write
Startup point 1
Waiting for send to finish...
+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
