Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSH0JyF>; Tue, 27 Aug 2002 05:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSH0JyF>; Tue, 27 Aug 2002 05:54:05 -0400
Received: from [195.185.133.146] ([195.185.133.146]:9739 "HELO
	gateway.hottinger.de") by vger.kernel.org with SMTP
	id <S315457AbSH0JyE> convert rfc822-to-8bit; Tue, 27 Aug 2002 05:54:04 -0400
Message-ID: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FDB@HBMNTX0.da.hbm.com>
From: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: interrupt latency
Date: Tue, 27 Aug 2002 11:58:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running and will in near future kernel 2.4.18 on an embedded system.

I have to speed up interrupt latency and need to understand how in what
timing tasklets are called and arbitraded.

I have to dig deep, but the kernel tree is quiet huge. As a non kernel
programmer I ask you, if anyone could give me a hint, where to start reading
from and which kernel source to pick first.

Any help highly appreaciated. 
(BTW: I will not bother you personaly with further questions unless you give
permission.)


What's behind it: We patched NMI and do some stuff we have to do very
regularly in there. After NMI we have to quiet fast start a kernel or even a
user space function with low latency. Also I measured 8 milliseconds after a
hardware interrupt before the corresponding interrupt function is called. At
RTI time it is even longer (around 12 microseconds). Need to find a way to
exactly understand why, and maybe speed up a bit.

Thank You.
Siegfried.


-------------
HBM - Hottinger Baldwin Messtechnik GmbH
Siegfried Wessler, Dipl.-Ing.
Entwicklung Messverstärker T-V
Im Tiefen See 45, D-64293 Darmstadt
Fon: 06151/803-884, Fax: -524
eMail: siegfried.wessler@hbm.com
 
