Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDNM3M>; Sat, 14 Apr 2001 08:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDNM3D>; Sat, 14 Apr 2001 08:29:03 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:39184 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132053AbRDNM2r>; Sat, 14 Apr 2001 08:28:47 -0400
Date: Sat, 14 Apr 2001 14:28:39 +0200
From: Kurt Roeckx <Q@ping.be>
To: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Message-ID: <20010414142839.A12760@ping.be>
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041318282003.00665@debian> <20010414000433.F4557@greenhydrant.com> <01041411380600.00516@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <01041411380600.00516@debian>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 11:38:06AM +0200, Andreas Peter wrote:
> Am Samstag, 14. April 2001 09:04 schrieb David Rees:
> 
> > OK, so it's not the RAID setup.  There's two things that can cause this.
> > One is that DMA is turned off  (what does hdparm /dev/hda and hdparm
> > /dev/hdc show?), the second was that the drives are on the same channel
> > (which obviously isn't the case here).  Can you verify that the drives are
> > in DMA mode?
> 
> hdparm /dev/hda 
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)

Does turning unmaskirq on help?


Kurt

