Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbRCVWq7>; Thu, 22 Mar 2001 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132221AbRCVWqu>; Thu, 22 Mar 2001 17:46:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131274AbRCVWqh>; Thu, 22 Mar 2001 17:46:37 -0500
Subject: Re: 2.4.2-ac21: aviplay slowdown
To: jp@ulgo.koti.com.pl (Jacek Pop³awski)
Date: Thu, 22 Mar 2001 22:48:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010322223608.A788@darkwood.tpnet.pl> from "Jacek Pop³awski" at Mar 22, 2001 10:36:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gDsL-0003TN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I compiled 2.4.3-pre6 and 2.4.2-ac21 and noticed, that aviplay works
> much worse than before. Avifile benchmark told me:
> 
> Average video output speed: 20.566223 Mb/s
> 
> On 2.2.18 and earlier 2.4.2-ac* it gives 50-55Mb/s.
> 
> mtrr is enabled:
> 
> [jp@darkwood jp]$ cat /proc/mtrr
> reg00: base=0xe8000000 (3712MB), size=  32MB: write-combining, count=2
> 
> My hardware: K6-2 500, VIA MVP3, Voodoo3

Are the numbers comparable if you have mtrr disabled on both the old and new 
kernel tree ?
