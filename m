Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282373AbRLICXT>; Sat, 8 Dec 2001 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282176AbRLICXD>; Sat, 8 Dec 2001 21:23:03 -0500
Received: from alpha.zimage.com ([216.86.199.2]:27919 "HELO alpha.zimage.com")
	by vger.kernel.org with SMTP id <S282373AbRLICWp>;
	Sat, 8 Dec 2001 21:22:45 -0500
From: Jeff Gustafson <method@zimage.com>
Reply-To: Jeff Gustafson <ncjeffgus@zimage.com>
Subject: Re: SMP 440GX+ hang on boot (2.4.16)
In-Reply-To: <m16CjXt-000OWoC@amadeus.home.nl>
Message-Id: <20011209022244.B06BB2F3F2@alpha.zimage.com>
Date: Sat,  8 Dec 2001 18:22:44 -0800 (PST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >        The funny thing is that the kernels from RH 7.2 (2.4.7-10) and Alan
> > Cox's latest (2.4.13-ac8) work just fine.  The 2.4.16 kernel does not 
> > work.  Is there a possiblity that the fix could posted to linux-kernel?  
> > Maybe it could be put into the upcoming 2.4.17 release.  Please??
> 
> 1) Did you enable ACPI in your own kernel ?

	No ACPI.  We used RH's 7.2 i686 SMP config file as a starting 
point to build 2.4.16.

> 2) Does "noapic" make a difference ?

	That made it worse.  Just gets stuck right in the middle of
initalizing the driver.  Before it would initialize, but couldn't mount
the root partition.

				...Jeff

