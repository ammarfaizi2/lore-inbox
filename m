Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313025AbSC0Oov>; Wed, 27 Mar 2002 09:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSC0Ool>; Wed, 27 Mar 2002 09:44:41 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:50393 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313025AbSC0Oo3>; Wed, 27 Mar 2002 09:44:29 -0500
Date: Wed, 27 Mar 2002 16:33:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.GSO.3.96.1020327142715.8602C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0203271631400.5751-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Maciej W. Rozycki wrote:

> On Wed, 27 Mar 2002, Zwane Mwaikambo wrote:
> 
> >  #define FIRST_DEVICE_VECTOR	0x31
> > +#define THERMAL_APIC_VECTOR	0x32	/* Thermal monitor local vector */
> >  #define FIRST_SYSTEM_VECTOR	0xef
> 
>  You certainly want to select a different vector.

Whats wrong with that vector? I tried to follow the guidelines as 
specified in hw_irq.h and opted to go for the lower priority ones, or 
is the vector not serviceable due to its range?

Thanks,
	Zwane

-- 
http://function.linuxpower.ca
		

