Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310375AbSCGQD4>; Thu, 7 Mar 2002 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310376AbSCGQDr>; Thu, 7 Mar 2002 11:03:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62735 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310380AbSCGQDc>; Thu, 7 Mar 2002 11:03:32 -0500
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
To: terje.eggestad@scali.com (Terje Eggestad)
Date: Thu, 7 Mar 2002 16:17:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        greearb@candelatech.com (Ben Greear),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <1015515815.4373.61.camel@pc-16.office.scali.no> from "Terje Eggestad" at Mar 07, 2002 04:43:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j0ae-0002l4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They normally adjust the STPCLK which is just fine. I've only seen a few
> > laptops that do it other ways. More fun are people running mixed 300/450
> > BP6 boards where the tsc varies by cpu
> 
> Can /proc/cpuinfo really be trusted in figuring out how long a cycle is?

The bogomip counter is a pretty good bet for any other system, and
gettimeofday() for the general case.
 

