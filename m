Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274784AbRIUTIB>; Fri, 21 Sep 2001 15:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274785AbRIUTHx>; Fri, 21 Sep 2001 15:07:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51100 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S274784AbRIUTHm>; Fri, 21 Sep 2001 15:07:42 -0400
Date: Fri, 21 Sep 2001 15:08:06 -0400
From: Greg Ward <gward@python.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010921150806.A2453@gerg.ca>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921205356.A1104@suse.cz>; from vojtech@suse.cz on Fri, Sep 21, 2001 at 08:53:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[my ATA/100 problem]
> Under 2.4.9, the boot-time delay is not quite as long, but it's still
> there.  And it's not nearly as noisy.  However, the end-result is the
> same: DMA is disabled for this drive; it's a lot slower than an ATA/100
> drive ought to be; if I force DMA back on, the first access to the drive
> has another looong delay that results in the kernel turning DMA back
> off.  Grumble.
> 
> This is a brand-new drive and brand-new cable.  The motherboard's only
> about 9 months old.
> 
> So: is this in fact a kernel problem? or is it more likely to be a cable
> problem, a motherboard problem, or a hard drive problem?

On 21 September 2001, Vojtech Pavlik said:
> Do you have the VIA IDE support enabled?

I have tried it both ways, but I think only with 2.4.2.  I've only tried
one 2.4.9 build, and that was with CONFIG_BLK_DEV_VIA82CXXX=y.  I've
just done another build with slightly different config settings
(suggestion from Mark Hahn), but haven't tried it yet.  It still has
both the VIA and Promise (CONFIG_BLK_DEV_PDC202XX=y) support enabled.

I'll report back when I've tried this kernel build.

        Greg
-- 
Greg Ward - Linux weenie                                gward@python.net
http://starship.python.net/~gward/
If ignorance is bliss, why aren't there more happy people?
