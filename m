Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTBFP2W>; Thu, 6 Feb 2003 10:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBFP2W>; Thu, 6 Feb 2003 10:28:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61454 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267335AbTBFP2V>; Thu, 6 Feb 2003 10:28:21 -0500
Date: Thu, 6 Feb 2003 16:37:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, ducrot@poupinou.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Message-ID: <20030206153757.GB19350@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz> <1044477704.1648.19.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044477704.1648.19.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Some people apparently want slower suspend/resume but have all caches
> > intact when resumed. Thats not easy for swsusp but they can have that
> > with S4bios. And S4bios is usefull for testing device support; it
> > seems to behave slightly differently to S3 meaning better testing.
> 
> Whether its slower depends on the hardware; on my 128MB Celeron 933
> laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> back up and running in around a minute and a half. That's about the same
> as far as I remember, but has (as you say) the advantage of not still
> having to get things swapped back in.
> 
> > If you already have hibernation partition from factory, which you are
> > using anyway for w98, S4bios is easier to use and more foolproof
> > (i.e. you can't boot into wrong kernel which does not resume but does
> > fsck instead).
> 
> It doesn't really matter what kernel is loaded when we start a resume
> anyway, does it? Could they not be different versions because one is
> going to replace the other anyway?

No, no. It has to be exactly the same kernel, otherwise you get a nice
crash (if you are lucky) and ugly data corruption (when you are not);
there's check to prevent that and panic, however.

That's why I call S4bios more foolproof.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
