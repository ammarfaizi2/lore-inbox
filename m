Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSCBWIv>; Sat, 2 Mar 2002 17:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310469AbSCBWIl>; Sat, 2 Mar 2002 17:08:41 -0500
Received: from dhcp45-21.dis.org ([216.240.45.21]:9220 "EHLO mass.dis.org")
	by vger.kernel.org with ESMTP id <S310468AbSCBWIX>;
	Sat, 2 Mar 2002 17:08:23 -0500
Message-Id: <200203022207.g22M7kx01385@mass.dis.org>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Marcin Gogolewski'" <marcing@ms-itti.com.pl>,
        linux-kernel@vger.kernel.org,
        "Mike Smith (E-mail)" <msmith@freebsd.org>
Subject: Re: Oops with ACPI (in sched:566) 
In-Reply-To: Your message of "Fri, 01 Mar 2002 10:49:35 PST."
             <59885C5E3098D511AD690002A5072D3C02AB7C9F@orsmsx111.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Mar 2002 14:07:46 -0800
From: Michael Smith <msmith@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't checked for BIOS updates for the SLT2 for a while, but in the 
code as of 6-12 months ago there is definitely a mutex deadlock.

Andrew already has all the details.

> > From: Marcin Gogolewski [mailto:marcing@ms-itti.com.pl]
> > I have STL2 machine, if I compile kernel (2.4.18) with ACPI I got:
> > [...] (I hope this is OK, I write it down from monitor ;-) )
> > ACPI: Core Subsystem version [20011018]
> > Scheduling in interrupt
> > kernel BUG at sched:566!
> 
> I've heard of problems with STL2 before, due to a poor ACPI BIOS.
> 
> If you're willing, I'd be great if you could get the ACPI pmtools
> (http://developer.intel.com/technology/iapc/acpi/downloads.htm), run
> acpidmp, and send me the output. At least then I can put the STL2 on the
> ACPI blacklist, and maybe we can figure out more about the problem, too.
> 
> Regards -- Andy

-- 
To announce that there must be no criticism of the president,
or that we are to stand by the president, right or wrong, is not
only unpatriotic and servile, but is morally treasonable to 
the American public.  - Theodore Roosevelt


