Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284867AbRLPWGP>; Sun, 16 Dec 2001 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLPWGF>; Sun, 16 Dec 2001 17:06:05 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:32888 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284867AbRLPWFy>; Sun, 16 Dec 2001 17:05:54 -0500
Date: Mon, 17 Dec 2001 00:05:24 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: malloc 1GB on a 2GB ia64 box fails - 17rc1 woes w/ qla1280 an d reiserfs
Message-ID: <20011217000524.L12063@niksula.cs.hut.fi>
In-Reply-To: <71714C04806CD5119352009027289217022C40F5@ausxmrr502.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <71714C04806CD5119352009027289217022C40F5@ausxmrr502.us.dell.com>; from Matt_Domsch@Dell.com on Sun, Dec 16, 2001 at 03:47:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 03:47:54PM -0600, you [Matt_Domsch@Dell.com] claimed:
> > It didn't boot, though. qla1280 just hung after "verifying 
> > chip" phase.
> > Strangely, I don't see any changes to qla1280.c in -rc1.
> 
> That's a known heisenbug on ia64, and it's been around for a while, not new
> to recent kernels.  Generally it disappears if you reboot, or try
> introducing debugging to find it...

Thanks for the info. In that case I'll try to boot 17rc1 a few times more. I
never saw this with .16 nor the Mandrake default .8mdk10. I had trouble
getting the initrd working with .17rc1 (never succeeded), so I compiled ext3
and qla1280 statically as opposed to .16 where I had them as modules. I
don't know if that has anything to do with it.

The reiserfs incident is still a bit worrying...


-- v --

v@iki.fi
