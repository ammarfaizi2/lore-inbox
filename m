Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129127AbRBUHPd>; Wed, 21 Feb 2001 02:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRBUHPY>; Wed, 21 Feb 2001 02:15:24 -0500
Received: from [209.53.18.145] ([209.53.18.145]:24723 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129127AbRBUHPU>;
	Wed, 21 Feb 2001 02:15:20 -0500
Date: Tue, 20 Feb 2001 23:15:02 -0800
From: Shane Wegner <shane@cm.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010220231502.A4618@cm.nu>
In-Reply-To: <20010220134028.A5762@suse.cz> <20010220155927.A1543@cm.nu> <20010221080919.A469@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010221080919.A469@suse.cz>; from vojtech@suse.cz on Wed, Feb 21, 2001 at 08:09:19AM +0100
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 08:09:19AM +0100, Vojtech Pavlik wrote:
> On Tue, Feb 20, 2001 at 03:59:27PM -0800, Shane Wegner wrote:
> 
> > > You wanted my VIA driver for 2.2. Here is a patch that brings the very
> > > latest 4.2 driver to the 2.2 kernel. The patch is against the
> > > 2.2.19-pre13 kernel plus yours 1221 ide patch.
> > 
> > This drivers breaks with my HP 8110 CD-R drive.  It's
> > sitting on primary slave of a Via 686B controler.  When I
> > try to do a hdparm -d1 -u1 -k1 /dev/hdb, the kernel locks
> > up hard.  Not even an oops.  Reverting to the old driver
> > works fine.
> 
> Don't do that. Use the kernel option to enable DMA instead.
> 
> Hmm, I'll have to look into this anyway - many users seem to do that and
> it isn't as harmless as it looks (it worked by pure luck with the
> previous version).
Ok, can I still use -u1 -k1 -c1 on the drives or is it even
necessary anymore.  Is the deprecation of -d1 VIA IDE
specific or does it apply to the entire subsystem.

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
