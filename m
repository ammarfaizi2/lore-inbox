Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSLPLIf>; Mon, 16 Dec 2002 06:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLPLIf>; Mon, 16 Dec 2002 06:08:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44552 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264788AbSLPLIe>; Mon, 16 Dec 2002 06:08:34 -0500
Date: Mon, 16 Dec 2002 12:16:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021216111629.GF19038@atrey.karlin.mff.cuni.cz>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212062150.06350.EricAltendorf@orst.edu> <20021209072911.GA2934@zaurus> <200212151940.25024.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212151940.25024.EricAltendorf@orst.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >
> > > > > Right ... I'm no kernel hacker so I don't know why, but I can
> > > > > only get the recent kernels to compile with sleep states if I
> > > > > turn *ON* software suspend as well.  However, as soon as I
> > > > > turn on swsusp and get a compiled kernel, it oops'es on boot.
> > > >
> > > > Can you mail me decoded oops?
> > > > 								Pavel
> > >
> > > This is the first time I've decoded an oops, and since I had to
> > > decode it on a different kernel (2.5.25) than the one I'm
> > > debugging (2.5.50 + Dec 6 ACPI patch), and I couldn't
> >
> > Can you try passing
> > "resume=hda5_or_whatever_your_swap_partition_is"?
> 
> Well, I've had "resume=/dev/hda6" in there the whole time (same as it 
> was on prior kernels that booted).  I tried passing "resume=hda6" 
> instead just for kicks and got the same result, though...  (This is 
> still on the 2.5.50 + Dec6ACPI kernel)

Strange... Can you report if it is still broken with 2.5.51?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
