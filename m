Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313046AbSC0QTg>; Wed, 27 Mar 2002 11:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313047AbSC0QTP>; Wed, 27 Mar 2002 11:19:15 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:25226 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313046AbSC0QTM>; Wed, 27 Mar 2002 11:19:12 -0500
Date: Wed, 27 Mar 2002 18:08:29 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.GSO.3.96.1020327170918.8602K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0203271805480.8973-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Maciej W. Rozycki wrote:

>  How can't it be critical?  Your system is overheating.  It is about to
> fail -- depending on the configuration, it'll either crash or be shut down
> by hardware (consider fire in the server room as well).  Either way the
> condition should be caught ASAP, for proper steps to be taken by the OS
> and/or the operator.  Otherwise it might have no second chance to get
> reported and the system will die silently -- you'll not know the reason
> until you get at the console (or its remains).  It may be too late then. 

I didn't mean to say that the condition was not critical, i meant that the 
interrupt generated is used for notification purposes, and in its current 
state the interrupt handler only provides information rather than taking 
measures due to the condition. The condition in this case is handled 
automatically by the hardware and we just receive notification via an 
interrupt getting triggered. However i have taken your suggestion and 
moved the vector.

Cheers,
	Zwane

 -- 
http://function.linuxpower.ca
		

