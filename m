Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbSLJVFa>; Tue, 10 Dec 2002 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSLJVFa>; Tue, 10 Dec 2002 16:05:30 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:8162 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266796AbSLJVF3>; Tue, 10 Dec 2002 16:05:29 -0500
Date: Wed, 11 Dec 2002 09:50:48 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <23440000.1039553448@localhost.localdomain>
In-Reply-To: <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com>
  <1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
 <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I strongly suspect that s4bios will work on this machine, but swsusp won't. 
Why?  It's a Dell Inspiron 8000 with an NVidia Geforce2go, and until NVidia 
put pm support in their driver, it's game over for Linux.  Except that the 
BIOS knows how to suspend it, so some kernel/driver combinations work with 
APM.  I suspect any Geforce2go Dell is the same.

Andrew

--On Tuesday, December 10, 2002 21:40:31 +0100 Pavel Machek <pavel@suse.cz> 
wrote:

> Hi!
>
>> > I concur with your pros and cons. This makes me think that if S4BIOS
>> > support ever gets added, it should get added to 2.4 only.
>
> And S4BIOS will never get added to 2.4 since it needs driver model
> :-(.
>
>> That assumes no box exists where S4bios works an S4 doesnt (eg due to
>> bad tables or "knowing" what other-os does)
>
> We have full control over S4 (== swsusp), so we can fix that in most
> cases.
>
> S4BIOS is still little friendlier to the user -- no need to set up
> swap partition and command line parameter, can't go wrong if you boot
> without resume=, etc.
> 								Pavel
>
> --
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


