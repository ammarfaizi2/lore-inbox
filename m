Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289185AbSBEHAc>; Tue, 5 Feb 2002 02:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSBEHAV>; Tue, 5 Feb 2002 02:00:21 -0500
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:1433 "EHLO
	hercules.oisec.net") by vger.kernel.org with ESMTP
	id <S289185AbSBEHAB>; Tue, 5 Feb 2002 02:00:01 -0500
Date: Tue, 5 Feb 2002 07:59:42 +0100
From: Cliff Albert <cliff@oisec.net>
To: Wojtek Pilorz <wpilorz@bdk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 512 Mb DIMM not detected by the BIOS!
Message-ID: <20020205065942.GA2141@oisec.net>
Mail-Followup-To: Wojtek Pilorz <wpilorz@bdk.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000001c1ac30$2ed408a0$0100a8c0@stratus> <Pine.LNX.4.21.0202041205110.7872-100000@celebris.bdk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202041205110.7872-100000@celebris.bdk.pl>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Don't do Windows, Just do Unix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 12:17:10PM +0100, Wojtek Pilorz wrote:

> > This is a chipset problem. Chipsets support up to x CAS (column) lines
> > and y RAS (row) lines, and depending on your DIMM memory module layout
> > and configuration, you 512MB DIMM will be detected as a different sized
> > module.
> > 
> > Eg. The venerable Intel 440BX (PII) chipset supports a max of 256MB per
> > slot. Ah well.
> > 
> 
> I had similar problem - on an Intel 440BX based motherboard (ABIT BX-133
> RAID) the 256MB DIMMs I originally got were only 'half-detected' (e.g. I
> got only 128MB from each one); These DIMMs were working OK on some
> VIA-based systems; after changing them to a different type (both old and
> new were ECC DIMMs from Kingston, just different type) they are working
> OK.
> 
> I it could be of any help, I can find the part numbers/names of my DIMMs.
> 
> > Since it's a chipset (ie hardware) issue, it's not possible to work
> > around this problem - you need a newer chipset. Sorry.
> Or maybe another DIMM type - at least I was able to successfully use 256MB
> DIMMs of appropriate type.

Double Sided 256MB Dimms are required, single sided dimms rarely work on
BX-based boards.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
