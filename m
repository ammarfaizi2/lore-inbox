Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135739AbRDXUkX>; Tue, 24 Apr 2001 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135741AbRDXUkN>; Tue, 24 Apr 2001 16:40:13 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:20228 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S135739AbRDXUkE>; Tue, 24 Apr 2001 16:40:04 -0400
X-Server-Uuid: 7edb479a-fd89-11d2-9a77-0090273cd58c
Message-ID: <3AE5E4A0.E6D5F6E9@sandia.gov>
Date: Tue, 24 Apr 2001 14:40:00 -0600
From: "Jim Schutt" <jaschut@sandia.gov>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Spurious interrupts for UP w/ IO-APIC on ServerWorks
X-Filter-Version: 1.3 (sass165)
X-WSS-ID: 16FB3B2A779281-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > I've got a dual-processor system built around the Intel SBT2 motherboard, 
> > which uses the ServerWorks LE chipset. 2.4.3 SMP works fine. When I 
> > build a UP kernel with IO-APIC support, I get this during boot: 
> 
> Turn off the OSB4 driver - bet that helps 

It does -- no more spurious interrupts.

Thanks -- Jim

-- 
Jim Schutt  <jaschut@sandia.gov>
Sandia National Laboratories, Albuquerque, New Mexico USA

