Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKPFm>; Thu, 11 Jan 2001 10:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbRAKPFd>; Thu, 11 Jan 2001 10:05:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28946 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129927AbRAKPFO>;
	Thu, 11 Jan 2001 10:05:14 -0500
Message-ID: <3A5DCB9D.2DAF83AF@mandrakesoft.com>
Date: Thu, 11 Jan 2001 10:05:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Thompson <nate@thebog.net>
CC: Robert Lowery <cangela@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: ACPI lockup on boot in 2.4.0
In-Reply-To: <001801c07bc4$e95ee250$0201a8c0@vaio> <20010111095853.A4442@eliot.thebog.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Thompson wrote:
> 
> On Thu, Jan 11, 2001 at 10:51:59PM +1100, Robert Lowery wrote:
> 
> > I compiled it with ACPI compiled as a module and APM not compiled in at all, but on booting I get the following.
> > ACPI: System description tables found
> > ACPI: System description tables loaded
> >
> > and then the system locks up..
> 
> I have a Sony Vaio PCG-F350 that behaves the same way.  I compiled in
> ACPI (not a module) and never got further than this.  When I enabled APM
> and disabled ACPI everything started to work.

To get a more verbose failure scenario, grab the ACPI debug version from
http://developer.intel.com/technology/IAPC/acpi/downloads.htm

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
