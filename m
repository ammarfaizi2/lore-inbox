Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSIFA0b>; Thu, 5 Sep 2002 20:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSIFA0b>; Thu, 5 Sep 2002 20:26:31 -0400
Received: from kullstam.ne.client2.attbi.com ([66.30.137.210]:39307 "HELO
	kullstam.ne.client2.attbi.com") by vger.kernel.org with SMTP
	id <S318169AbSIFA0b>; Thu, 5 Sep 2002 20:26:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC in SMP dual Athlon XP1800
References: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz>
	<200209051453.54728.scorpionlab@ieg.com.br>
	<1031250810.7367.0.camel@irongate.swansea.linux.org.uk>
From: Johan Kullstam <kullstj-ml@attbi.com>
Organization: none
Date: 05 Sep 2002 20:31:08 -0400
In-Reply-To: <1031250810.7367.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <m2ofbcrmb7.fsf@euler.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Thu, 2002-09-05 at 18:53, Scorpion wrote:
> > Hi All,
> > I got my Dual Athlon XP1800 working now. 
> > Everything gonna well after changed MP 1.4 Support to disable in BIOS, and 
> > leaving MP table enabled.
> > Anyone knows if linux 2.4.19 has not yet a full implemantation of MP 1.4 or if 
> > it is just a BIOSes bug?
> 
> On the 1004 BIOS with the ASUS it seems to be a bios table error. Later
> BIOSes fixed it, then removed the option, then broke lots of other
> stuff. I went back to 1004 so I dont know how the newest fare

I am using 1006.  I have enabled MP 1.4 in order to get the IRQ
numbers 16 and beyond.  I am not sure how useful that is since several
PCI IRQs are shared and there are lots of free ones.  Anyhow, MP 1.1
works just fine too.  I am using the Athlon MP 1900+ CPUs.

Note to anyone who is considering this cpu/motherboard, this combo
uses *shedloads* of power.  400W is *not* enough (I've seen Alan post
to this effect before but it bears repeating).  Also, make sure you
have good case airflow -- all that power that is being consumed is
being turned into heat.  Aftermarket CPU heatsink and fan are a good
idea.  Unfortunately, it is a bit crowded for 80mm CPU fans though.

Things are stable now once I mitigated the heat death problem.

-- 
Johan KULLSTAM
