Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCZWGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCZWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:06:04 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:14720 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261357AbUCZWF6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:05:58 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
Date: Fri, 26 Mar 2004 17:05:55 -0500
User-Agent: KMail/1.6.1
References: <200403261430.18629.praedor@yahoo.com> <200403261800.32717.praedor@yahoo.com> <1080338266.5408.316.camel@cog.beaverton.ibm.com>
In-Reply-To: <1080338266.5408.316.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403261705.55657.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 26 March 2004 04:57 pm, john stultz held forth thus:
> On Fri, 2004-03-26 at 15:00, Praedor Atrebates wrote:
[...]
> > On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> > > On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > > > In doing a web search on system clock speeds being too high, I found
> > > > entries describing exactly what I am experiencing in the linux-kernel
> > > > list archives, but have not yet found a resolution.
> > > >
> > > > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
> > > > 1412 laptop, celeron 366, 512MB RAM.  I am finding that my system
> > > > clock is ticking away at a rate of about 3:1 vs reality, ie, I count
> > > > ~3 seconds
[...]
> > > Does booting w/ "clock=pit" help?
[...]
> I noticed in the dmesg you sent me that you're using the ACPI PM time
> source. There has just recently been a bug opened for a very similar
> issue (see http://bugme.osdl.org/show_bug.cgi?id=2375 ).
>
> First of all, scratch trying "clock=pit" and test booting w/
> "clock=tsc". If that resolves the issue, disable ACPI PM timesource
> support (under the ACPI menu) in your kerel and that should fix you for
> the short term.

Hmpf.  I'll try the clock=tsc switch next.  I did boot using the clock=pit 
switch and the clock was normal...but I had also changed the append statement 
acpi=on to acpi=off as well.  I'll set it back to "on" and try "clock=tsc" in 
combination.

My bios is very limited.  This is a rather old laptop and there is just not a 
lot I can do.  I'll check it one more time as I reboot.

Thanks for the help.

praedor

- -- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
- --Barbara Bush, his mother
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZKlDSTapoRk9vv8RAvmWAJ94jPIPaSwdrtOoNkwKpz4eKokBjwCglolS
ih1YhCpj706DtrVFt7Y42bs=
=oW8n
-----END PGP SIGNATURE-----
