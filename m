Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTEVRYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTEVRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:24:13 -0400
Received: from ns2.jaj.com ([66.93.21.106]:42940 "EHLO ns2.jaj.com")
	by vger.kernel.org with ESMTP id S262856AbTEVRYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:24:11 -0400
Date: Thu, 22 May 2003 13:37:14 -0400
From: Phil Edwards <phil@jaj.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk.  Am I doomed?
Message-ID: <20030522173714.GB22728@disaster.jaj.com>
References: <20030522134847.GA20179@disaster.jaj.com> <20030522161939.GA23140@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522161939.GA23140@tsunami.ccur.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 12:19:39PM -0400, Joe Korty wrote:
> On Thu, May 22, 2003 at 09:48:47AM -0400, Phil Edwards wrote:
> > In the aftermath of a horrible crash (one minute all was well, the next
> > minute all the active ext3 filesystems behaved like they'd been run through a
> > cheese grater), I've installed a 200GB Maxtor drive, and a Promise Ultra133
> > TX2 card to let me actually use all of it.
> > 
> > The mobo BIOS doesn't speak 48-bit LBA, so it sees a 137 GB drive.  That's
> > fine, I'm guessing, since (I'm told) Linux doesn't get its information
> > from the BIOS.
> 
> I believe LBA48 was introduced in 2.4.21-pre.  Try 2.4.21-rc2 and see what
> happens.

I know that LBA48 wasn't in the 2.4.19 kernel that was on the
boot/installation media I was using; cfdisk and everything else only saw
the 137.  Once I installed 2.4.20, the kernel and all the tools can see
the whole drive; just the BIOS listing is still wrong.

(Well, can't boot off the drive with GRUB in the MBR.  So there may still
be something wrong there.  Lose2K can boot from that drive, but not the
latest GRUB.)

I will try to give .21-rc2 a spin before I go out of town next week.  Thanks!


Phil

-- 
If ye love wealth greater than liberty, the tranquility of servitude greater
than the animating contest for freedom, go home and leave us in peace.  We seek
not your counsel, nor your arms.  Crouch down and lick the hand that feeds you;
and may posterity forget that ye were our countrymen.            - Samuel Adams
