Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313041AbSC0QGE>; Wed, 27 Mar 2002 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313040AbSC0QFy>; Wed, 27 Mar 2002 11:05:54 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:49799 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313041AbSC0QFs>; Wed, 27 Mar 2002 11:05:48 -0500
Date: Wed, 27 Mar 2002 17:55:03 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.GSO.3.96.1020327161054.8602D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0203271754040.8973-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Maciej W. Rozycki wrote:

>  You can't use a vector that is in the range assigned to I/O APIC
> interrupts (i.e.  0x31 - 0xee).  Otherwise you'll get an overlap when the
> vector gets assigned to an ordinary IRQ line.  Also you probably want a
> high-priority interrupt as the condition is serious, if not critical --
> system failures, such as bus exceptions, machine check faults, parity
> errors, power failures, etc. demand a high priority service. 

Would f0 be ok? But i see its assigned for "future linux use"

Thanks,
	Zwane

-- 
http://function.linuxpower.ca
		

