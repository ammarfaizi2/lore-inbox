Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTCGBSd>; Thu, 6 Mar 2003 20:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbTCGBSd>; Thu, 6 Mar 2003 20:18:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39908 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261328AbTCGBSc>;
	Thu, 6 Mar 2003 20:18:32 -0500
Date: Fri, 7 Mar 2003 01:29:05 +0000
From: Chris Dukes <pakrat@www.uk.linux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307000816.P838@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Mar 07, 2003 at 12:08:16AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:08:16AM +0000, Russell King wrote:
> > 
> > You can build the dhcp client with glibc static into your initrd. Its hardly
> > magic or special programs or random garbage, and last time I counted it came
> > to one program. Dunno what the other 999 utilities your dhcp needs are ?
> 
> How about mount for nfs-root, a shell and a shell script to supply the
> correct parameters to mount so it doesn't go and try to mount the
> nfs-root with locking enabled - oh, and a few programs like sed and
> so forth to pull the mount parameters out of the dhcp client output,
> if there is such an output.

If IBM can fit a kernel and a ramdisk containing all the utilities you
describe and more in smaller than 5M of file for tftp, one would think 
that it could be done on Linux.
> 
> ipconfig.c does more than just configure networking.  It's a far smaller
> solution to NFS-root than any userspace implementation could ever hope
> to be.

That's nice.  Would you mind explaining to us where that would be a
benefit?  Aside from dead header space in elf executables, I'm at
a loss as to how a usermode implementation must be significantly
larger than kernel code.

-- 
Chris Dukes
I tried being reasonable once--I didn't like it.
