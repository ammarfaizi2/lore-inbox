Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272008AbRIMT4W>; Thu, 13 Sep 2001 15:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRIMT4M>; Thu, 13 Sep 2001 15:56:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44049 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272008AbRIMTzz>; Thu, 13 Sep 2001 15:55:55 -0400
Date: Thu, 13 Sep 2001 21:56:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Edgar Toernig <froese@gmx.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Message-ID: <20010913215617.E6820@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz> <3BA0D2BA.8B972B51@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3BA0D2BA.8B972B51@gmx.de>; from froese@gmx.de on Thu, Sep 13, 2001 at 05:37:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
> > > et voila, it worked perfectly.
> > 
> > Do you have patch to do that?
> 
> I have a patch for 2.0.x only.  But it should be enough to change the
> disksizes table at the end of bootsect.S to:
> 
> disksizes: .byte 18,18,18,18

Yep, tried that. No more crc errors when decompressing. Instead,
sudden reboot when it finishes loading. OOps.

This is 486sx/25 booting from network. Kernel is 2.4.9, compiled with
math emu, and processor=386.  Any ideas what is wrong?
								Pavel

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
