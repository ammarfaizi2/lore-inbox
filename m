Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135732AbRDXUH1>; Tue, 24 Apr 2001 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135734AbRDXUHR>; Tue, 24 Apr 2001 16:07:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135732AbRDXUHK>; Tue, 24 Apr 2001 16:07:10 -0400
Subject: Re: Spurious interrupts for UP w/ IO-APIC on ServerWorks
To: jaschut@sandia.gov (Jim Schutt)
Date: Tue, 24 Apr 2001 21:08:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AE5D9AA.4A743730@sandia.gov> from "Jim Schutt" at Apr 24, 2001 01:53:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s96X-0002qg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a dual-processor system built around the Intel SBT2 motherboard,
> which uses the ServerWorks LE chipset.  2.4.3 SMP works fine.  When I 
> build a UP kernel with IO-APIC support, I get this during boot:

Turn off the OSB4 driver - bet that helps

> 2.4.3 has this behavior, 2.4.3-ac9 works fine. I found this in the -ac
> changelog; perhaps it's relevant:
> 
> > 2.4.2-ac12 
> [...]
> > o Remove serverworks handling. The BIOS is our (me) 
> >         best (and right now only) hope for that chip 

Yep. Thats the bug fix you need.

