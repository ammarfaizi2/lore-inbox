Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313452AbSDLMc3>; Fri, 12 Apr 2002 08:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313562AbSDLMc2>; Fri, 12 Apr 2002 08:32:28 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:54251 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313452AbSDLMc1>; Fri, 12 Apr 2002 08:32:27 -0400
Date: Fri, 12 Apr 2002 08:38:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: VFS: Unable to mount root fs on 08:06 - 2.4.19-pre6
Message-ID: <20020412083830.A28260@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kernel panic: VFS: Unable to mount root fs on 08:06

> I had the exact same problem (but much different hardware) with the 2.5.6-pre3 kernel. See:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101548222601049&w=2
> 
> I'd try CONFIG_SMP=n just to change the playing field

Thanks for the input.  
With CONFIG_SMP=n, CONFIG_HIGHMEM4G=y (instead of 64G), 
and the printk from that thread it boots with:

megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
megaraid: no BIOS enabled.
scsi5 : SCSI host adapter emulation for IDE ATAPI devices
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 3
..
mount had returned -6
ext3
VFS: Cannot open root device "806" or 08:06
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:06

-- 
Randy Hron

