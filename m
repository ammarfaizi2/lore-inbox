Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCZV5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUCZV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:57:34 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:12160 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261355AbUCZV5Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:57:25 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
Date: Fri, 26 Mar 2004 16:57:06 -0500
User-Agent: KMail/1.6.1
References: <200403261430.18629.praedor@yahoo.com> <4064A4B7.5030103@mvista.com>
In-Reply-To: <4064A4B7.5030103@mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403261657.22738.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 26 March 2004 04:46 pm, George Anzinger held forth thus:
> Praedor Atrebates wrote:
> > In doing a web search on system clock speeds being too high, I found
> > entries describing exactly what I am experiencing in the linux-kernel
> > list archives, but have not yet found a resolution.
> >
> > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
> > 1412 laptop, celeron 366, 512MB RAM.  I am finding that my system clock
> > is ticking away at a rate of about 3:1 vs reality, ie, I count ~3 seconds
> > on the system clock for every 1 real second.  I am running ntpd but this
> > is unable to keep up with the rate of system clock passage.
[...]
> Try this in the boot command line "clock=pmtmr".  If that fails, then try
> "clock=pit".

What is the difference between the two settings?  I used the latter and it 
worked (didn't try "clock=pmtmr").

praedor

- -- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
- --Barbara Bush, his mother
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZKdCSTapoRk9vv8RAhPDAKDTnTfPABRkJxj0Gy/14d2SsiLL8wCg5r1+
XoUhJcQbDzshPIT++0x/g9o=
=6j96
-----END PGP SIGNATURE-----
