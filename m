Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269875AbRHIXfL>; Thu, 9 Aug 2001 19:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270618AbRHIXel>; Thu, 9 Aug 2001 19:34:41 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:59664 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S270606AbRHIXdb>; Thu, 9 Aug 2001 19:33:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: kapm-idled shows 90+% cpu usage when idle
Date: Thu, 9 Aug 2001 19:33:42 -0400
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010809233425Z270606-28344+3498@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a true usage reading or just some quirk that's supposed to happen?   
I really doubt that this kernel daemon should really be using  cpu.  It seems 
to respond with a higher cpu usage when i'm idle.  It immediately goes away 
when something else uses cpu.   If you need any more info just ask.   I'm 
 
I'm using 2.4.8-pre7  
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP] 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)

I didn't see acpi in my motherboard manual at the time of configuring the 
kernel, should i be using the acpi idle daemon instead of the supposedly 
supported APM idle daemon?
