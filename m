Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSBDLSz>; Mon, 4 Feb 2002 06:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSBDLSo>; Mon, 4 Feb 2002 06:18:44 -0500
Received: from celebris.bdk.pl ([212.182.99.100]:46852 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S288914AbSBDLSf>;
	Mon, 4 Feb 2002 06:18:35 -0500
Date: Mon, 4 Feb 2002 12:17:10 +0100 (CET)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Daniel J Blueman <daniel.blueman@btinternet.com>
cc: "'Benny Sjostrand'" <gorm@cucumelo.org>, linux-kernel@vger.kernel.org
Subject: RE: 512 Mb DIMM not detected by the BIOS!
In-Reply-To: <000001c1ac30$2ed408a0$0100a8c0@stratus>
Message-ID: <Pine.LNX.4.21.0202041205110.7872-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Daniel J Blueman wrote:

> Date: Sat, 2 Feb 2002 21:25:44 -0000
> From: Daniel J Blueman <daniel.blueman@btinternet.com>
> To: 'Benny Sjostrand' <gorm@cucumelo.org>, linux-kernel@vger.kernel.org
> Subject: RE: 512 Mb DIMM not detected by the BIOS!
> 
> Hey Benny,
> 
> This is a chipset problem. Chipsets support up to x CAS (column) lines
> and y RAS (row) lines, and depending on your DIMM memory module layout
> and configuration, you 512MB DIMM will be detected as a different sized
> module.
> 
> Eg. The venerable Intel 440BX (PII) chipset supports a max of 256MB per
> slot. Ah well.
> 

I had similar problem - on an Intel 440BX based motherboard (ABIT BX-133
RAID) the 256MB DIMMs I originally got were only 'half-detected' (e.g. I
got only 128MB from each one); These DIMMs were working OK on some
VIA-based systems; after changing them to a different type (both old and
new were ECC DIMMs from Kingston, just different type) they are working
OK.

I it could be of any help, I can find the part numbers/names of my DIMMs.

> Since it's a chipset (ie hardware) issue, it's not possible to work
> around this problem - you need a newer chipset. Sorry.
Or maybe another DIMM type - at least I was able to successfully use 256MB
DIMMs of appropriate type.

I also don't think kernel tricks would not get back the lost memory here.

> 
> Dan
> 
> ____________________
> Daniel J Blueman 
> 
> > I'm new to this mailinglist so please tellme if you think i'm "out of 
> > topoic".
> > 
> > I've have trouble with the following issue:
> > On two x86 machines, one AMD k62 and a Pentium the Bios dont wont to 
> > detect properly a 512 MB PC133 DIMM, the K62 based it dont 
> > detect it at 
> > all, and on the PII it detect it as a 128MB DIMM.
> > I suspect that's the BIOS that "sucks", not the HW, i supose 
> > that the HW 
> > is capable to deal with 512MB DIMM's, so my question to you 
> > "kernel-gurus", is there any posibility to configure the 
> > Linux kernel to 
> > bypass the BIOS and actually use my 512MB ?
> > 
> > Thanks!
> > 
> > /Benny


