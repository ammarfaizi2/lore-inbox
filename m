Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTABSvD>; Thu, 2 Jan 2003 13:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTABSvD>; Thu, 2 Jan 2003 13:51:03 -0500
Received: from linux.kappa.ro ([194.102.255.131]:40086 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S266330AbTABSvB>;
	Thu, 2 Jan 2003 13:51:01 -0500
Date: Thu, 2 Jan 2003 20:59:21 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
Message-ID: <20030102185921.GA28107@linux.kappa.ro>
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041536269.24901.47.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 07:37:49PM +0000, Alan Cox wrote:
> On Thu, 2003-01-02 at 18:29, Teodor Iacob wrote:
> > Hello,
> > 
> > Today i mounted a HDD on my secondary IDE on a 40 pin cable and surprise
> > the kernel set it up on UDMA 133:
> > 
> > hdd: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(133)
> 
> What controller and disks ?

Sorry I didn't append this info from the first time.. there it goes:

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)

hdd: Maxtor 6Y060L0, ATA DISK drive

the harddisk is DiamondPlus9 60GB 7200 rpm UDMA133 .. and the mainbboard is Soltek 75-FRV
with KT400 chipset

> 
> > I wouldn't have notice this unless I got some errors:
> 
> It got CRC errors, not suprisingly and will drop back. Nevertheless it
> shouldnt have gotten this wrong, so more info would be good.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
