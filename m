Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289620AbSAWBWD>; Tue, 22 Jan 2002 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289619AbSAWBVy>; Tue, 22 Jan 2002 20:21:54 -0500
Received: from port-212-202-169-67.reverse.qdsl-home.de ([212.202.169.67]:23058
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S289617AbSAWBVn> convert rfc822-to-8bit; Tue, 22 Jan 2002 20:21:43 -0500
Date: Wed, 23 Jan 2002 02:20:54 +0100 (CET)
Message-Id: <20020123.022054.884034824.rene.rebe@gmx.net>
To: sgy@amc.com.au
Cc: linux-kernel@vger.kernel.org, xioborg@yahoo.com
Subject: Re: Athlon PSE/AGP Bug
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <5.1.0.14.0.20020123112137.009ef8b0@mail.amc.localnet>
In-Reply-To: <1011737673.10474.12.camel@psuedomode>
	<c5qr4uk3adm53fgvuibld2tnjtnfnq0a5i@4ax.com>
	<5.1.0.14.0.20020123112137.009ef8b0@mail.amc.localnet>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Young <sgy@amc.com.au>
Subject: Re: Athlon PSE/AGP Bug
Date: Wed, 23 Jan 2002 11:36:56 +1100

> At 04:52 PM 22/01/02 -0600, Steve Brueggeman wrote:
> >I would like to see some indication that someone is collecting data
> >related to "running stable with mem=nopentium on Athelon
> >architecture", and maybe we can see a pattern here.  Heck maybe we see
> >2 or 3 different patterns here.
> 
> Well I'm quite willing to give all the system specs we have at work and the 
> ones I have at home (all up, this is about 12 Athlon's that are running 
> Linux, all running fine so far with no issues) towards this process.
> 
> I've not seen your system specs, so I'm wondering what sort of m/board you 
> have? The mention of the SiS AGP support makes me wonder if you are running 
> an SiS chipset board. In the past, Linux kernel developers and the XFree86 
> team have had a huge amount of trouble (or in some cases, flat refusal) in 
> getting certain (usually up to date) specs out of SiS, and I'm wondering if 
> maybe this could be related somehow, as none of the systems I've got have 
> an SiS chipset in them (they are all AMD or VIA chipsets).

Yes the docs and driver for the graphic part of the sis630 suck (I
helped debuggin/hacking it ...) - but the sis735 runs rock solid here!
Using a mga450 and an Athlon XP1700+.

Here I only see one Athlon system crashing all the time. This is a
700Mhz Duron runnign in a Asus A7V. With a 2.4.16 kernel compiled with
Athlon optimization all applications are crashing all time (sed, cc,
gcc, sawfish - all. Simply sig-11), with a 2.4.4 kernel (using the
same .config) it seem to run just fine. 4 passes of memtest86 showed
no error, either ...

I see the broken via chips involved most of the time.

We will try a i386-only optimized kernel tomorrow.

> Now I'm not saying this is an SiS issue, but maybe it's more prevalent with 
> SiS chipsets? Until we get some hard data, who knows!
> 
> 
> Stuart Young - sgy@amc.com.au
> (aka Cefiar) - cefiar1@optushome.com.au
> 
> [All opinions expressed in the above message are my]
> [own and not necessarily the views of my employer..]


k33p h4ck1n6 and goo night
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
