Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313451AbSC2PA2>; Fri, 29 Mar 2002 10:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313452AbSC2PAS>; Fri, 29 Mar 2002 10:00:18 -0500
Received: from smtp02.vsnl.net ([203.197.12.8]:24574 "EHLO smtp02.vsnl.net")
	by vger.kernel.org with ESMTP id <S313451AbSC2PAC>;
	Fri, 29 Mar 2002 10:00:02 -0500
Message-ID: <3CA48237.EA4D3F08@vsnl.net>
Date: Fri, 29 Mar 2002 20:33:19 +0530
From: "Amit S. Kale" <kgdb@vsnl.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: announce: kgdb 1.5 with reworked buggy smp handling
In-Reply-To: <30144.1017399590@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Fri, 29 Mar 2002 16:01:36 +0530,
> "Amit S. Kale" <kgdb@vsnl.net> wrote:
> >kgdb 1.5 at http://kgdb.sourceforge.net/
> >
> >smp handling is completely reworked. Previous kgdb had a bug
> >which caused it to hang when a processor spun with
> >interrupts disabled and another processor enters kgdb. kgdb
> >now uses nmi watchdog for holding other processors while
> >a machine is in kgdb.
> 
> IA64 disabled spin loops ignore NMI :(.

Thanks for the info.

Isn't there any way get into an interrupt disabled spinning
processor on an ia64 smp machine?
-- 
Amit S. Kale
Linux kernel source level debugger    http://kgdb.sourceforge.net/
	[29th March - kgdb-1.5 with reworked smp handling.]
Translation filesystem                http://trfs.sourceforge.net/

