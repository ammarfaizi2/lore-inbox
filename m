Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314729AbSD2B0o>; Sun, 28 Apr 2002 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314732AbSD2B0n>; Sun, 28 Apr 2002 21:26:43 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:14066 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314729AbSD2B0n>; Sun, 28 Apr 2002 21:26:43 -0400
Date: Sun, 28 Apr 2002 18:26:17 -0700
From: Chris Wright <chris@wirex.com>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.10-dj1
Message-ID: <20020428182617.A8654@figure1.int.wirex.com>
Mail-Followup-To: Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020427030823.GA21608@suse.de> <200204271313.g3RDD4024060@smtp1.wanadoo.nl> <20020427155116.I14743@suse.de> <200204281145.g3SBjJJ20178@smtp2.wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rudmer van Dijk (rudmer@legolas.dynup.net) wrote:
> On Saturday 27 April 2002 15:51, Dave Jones wrote:
> > On Sat, Apr 27, 2002 at 02:51:21PM +0200, Rudmer van Dijk wrote:
> >  > The system also hangs after fscking my root partition (fsck completed
> >  > without errors)
> >  > After my harddisks went to sleep I switched the system off and after
> >  > booting the kernel (2.4.19-pre7) panics (and the caps- and scroll-lock
> >  > leds are blinking) as it can not mount the root fs due to the following
> >  > errors: EXT2-fs error (device ide0(3,1)): ext2_check_descriptors: Block
> >  > bitmap for group 0 not in group (block 0)!
> >  > EXT2-fs: group descriptors corrupted!
> > 
> > This is somewhat disturbing. I'll look over the VFS changes, but I'm not
> > aware of anything added specifically to my tree that could cause this,
> > so it may be either an ext2 issue in mainline, or one of the drivers.

I had the same problem with mainline 2.5.10.  fsck is hanging trying to
acquire BKL.

cheers,
-chris
