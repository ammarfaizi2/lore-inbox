Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbRDRFrL>; Wed, 18 Apr 2001 01:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDRFrD>; Wed, 18 Apr 2001 01:47:03 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:46599 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S133023AbRDRFqy>; Wed, 18 Apr 2001 01:46:54 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A32.001F8ED2.00@d73mta05.au.ibm.com>
Date: Wed, 18 Apr 2001 11:13:51 +0530
Subject: 2.4.0-test8 compilation problem on netfinity
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I compile the 2.4.0-test8 kernel on uniprocessor intel machine with SMP
support, I get no compilation problems. But when I compile on a 'netfinity'
machine with 3 intel processors with SMP support, the telnet session in
which I do this gets hung during 'make bzImage'. Though the 'bzImage' still
gets created but when I try to boot the netfinity with that image, the
system crashes and I get the following kernel messages:

Calibrating delay loop... 1795 Bogo MIPS
Stack at about c1e1bfbc
OK.
CPU1: Intel Pentium III (Cascades) stepping 04
CPU has booted.
Booting processor 2/6 eip 2000
Setting warm reset code and vector
1.
2.
3.
asserting INIT.
Waiting for send to finish...
Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2
Sending STARTUP #1.
After APIC write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write
(the above line was the last thing written to the screen, it was then froze
at this point for at least 5 min.)

Has anybody faced this problem before? If anybody has booted the 2.4.x with
SMP support on the netfinity multi-processor machienes, kindly tell me the
way.

Regards,
Daljeet Maini


