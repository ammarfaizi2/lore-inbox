Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSEKKgN>; Sat, 11 May 2002 06:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEKKgM>; Sat, 11 May 2002 06:36:12 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:16900 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S314671AbSEKKgL>; Sat, 11 May 2002 06:36:11 -0400
Date: Sat, 11 May 2002 13:32:14 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3com 3c905cx-tx-nm "unknown device"
Message-ID: <20020511133214.B768@actcom.co.il>
In-Reply-To: <20020511103650.A790@actcom.co.il> <3CDCD159.8F9049C4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 01:07:53AM -0700, Andrew Morton wrote:
> Muli Ben-Yehuda wrote:
> > lspci -vx (with the latest pci.ids file) shows:
> > 
> > 00:09.0 Ethernet controller: 3Com Corporation: Unknown device ffff (rev 78)
> >      Flags: bus master, medium devsel, latency 64, IRQ 11
> >      I/O ports at 6500 [size=128]
> >      Expansion ROM at <unassigned> [disabled] [size=128K]
> >      Capabilities: [dc] Power Management version 2
> > 00: b7 10 ff ff 07 00 10 02 78 00 00 02 08 40 00 00
> > 10: 01 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
> > 30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 1e 3f
> 
> PCI IDs are 0xffff.  Normally that is supplied from the EEPROM (we think).
> 
> Try setting the NIC up with 3com's DOS-based setup program 
> ftp://ftp.3com.com/pub/nic/3c90x/3c90xx2.exe and also check your
> BIOS power management settings, PnP OS settings, etc.

The BIOS setting have all been tweaked to death, with no apparent
change. I tried the setup program on windows 95, and it failed to
detect the card as well. 

> Try to work out why the EEPROM hasn't been powered up - could be
> a dead card (test it under Windows) or a BIOS thing.

I'll try to test the card on a different computer running a reasonably
recent version of windows, and I'll try to get another unit of the
same card to try with linux. I'll inform the list of any conclustions.
Thanks!
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
