Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTB0QBq>; Thu, 27 Feb 2003 11:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTB0QBq>; Thu, 27 Feb 2003 11:01:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2059 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265361AbTB0QBp>; Thu, 27 Feb 2003 11:01:45 -0500
Date: Thu, 27 Feb 2003 17:12:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Robert Woerle Paceblade/Support <robert@paceblade.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
Message-ID: <20030227161203.GF12434@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com> <20030227151907.GC12434@atrey.karlin.mff.cuni.cz> <20030227154922.GY13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227154922.GY13404@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >>OK, looks reasonable. Can you also gen up a patch documenting this in
> > > >>kernel-parameters.txt?
> > > >>   
> > > >>
> > > >
> > > >You can, assuming you took the patch ;-).
> > > > 
> > > >
> > > well how can i find the correct value`s to put in ??
> > 
> > Well, similar method to how you use mem=123@456 parameters. You just
> > guess them. [Given kernel messages, it is actually quite easy.]
> > 
> 
> If I understand you,  you then just have to mem= with the correct
> value reported via, for example:
> 
> ducrot@novae:~$ dmesg | grep 'ACPI data'
>  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)

Well, for you bios map is okay and you don't need mem= parameter.

> But big problem though.  It is really really strange that the
> BIOS mainteners have broken e820 call, are you sure you have
> enabled acpi in BIOS, and/or power management ?

Yes, what I needed was bios update. If you downgrade your bios you can
provoke same bug I saw.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
