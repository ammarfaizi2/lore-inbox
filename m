Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRCASs6>; Thu, 1 Mar 2001 13:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRCASsr>; Thu, 1 Mar 2001 13:48:47 -0500
Received: from unthought.net ([212.97.129.24]:12263 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129774AbRCASsj>;
	Thu, 1 Mar 2001 13:48:39 -0500
Date: Thu, 1 Mar 2001 19:48:37 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org, Tim Walberg <tewalberg@mediaone.net>
Subject: Re: smartmedia adapter support??
Message-ID: <20010301194837.B11442@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Tim Walberg <tewalberg@mediaone.net>
In-Reply-To: <20010301100041.A22824@mediaone.net> <20010301175002.H7883@dss19>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010301175002.H7883@dss19>; from steffen@gfz-potsdam.de on Thu, Mar 01, 2001 at 05:50:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 05:50:04PM +0100, Steffen Grunewald wrote:
> On Thu 2001-03-01 (10:00), Tim Walberg wrote:
> > Just wondering whether anyone has successfully gotten
> > either a PCMCIA SmartMedia Adapter (specifically the
> > Viking Components one) or a FlashPath floppy SmartMedia
> > adapter working under 2.4.x. I've got both, and haven't
> > gotten either working under either 2.2.x or 2.4.x, but
> > I haven't had the time to work real hard at it either,
> > so I'm hoping someone can give me some pointers...
> 
> http://www.smartdisk.com has a driver (which includes a binary-
> only library) for FlashPath that you can compile for your kernel
> 
> Works fine here (2.2.16)
> 
> Don't know about PCMCIA though

I'm using a PCMCIA SmartMedia adapter from Hagiwara here, it worked
out of the box with 2.2.19pre5 (the first kernel I tried, no particular
reason behind the version).   No patches, no libraries, no bull.

This laptop is a pile of crap and most PCMCIA related stuff tends to
break randomly  -  but this card has worked flawlessly all the time.

The trasfer-rate from a 32MByte flash card is roughly 800 KB/sec, it 
can't do DMA.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
