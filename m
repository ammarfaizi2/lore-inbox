Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265464AbRFVQcm>; Fri, 22 Jun 2001 12:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbRFVQcc>; Fri, 22 Jun 2001 12:32:32 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:43017 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265464AbRFVQcU>; Fri, 22 Jun 2001 12:32:20 -0400
Date: Fri, 22 Jun 2001 11:32:09 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
Subject: Re: For comment: draft BIOS use document for the kernel
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <JajKKC.A.Ay.KM3M7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Alan Cox <alan@lxorguk.ukuu.org.uk> on Fri, 22 Jun
2001 17:20:33 +0100 (BST)


> Firstly a call is made to BIOS INT 15  AX=0xE820 in order to read the
> E820 map. A maximum of 32 blocks are supported by current kernels. The
> 'SMAP' signature is required and tested. In addition the SMAP signature
> is restored each call, although not required by the specification in order
> to handle some know BIOS bugs.

FYI, in OS/2, the E820 call is made only on machines with a Pentium Pro or
higher, because apparently (and this is my guess) there are some motherboards
out there with older CPUs that don't return a reliable result to the E820 call.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

