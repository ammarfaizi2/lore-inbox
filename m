Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLJUcu>; Tue, 10 Dec 2002 15:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLJUct>; Tue, 10 Dec 2002 15:32:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43530 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264745AbSLJUct>; Tue, 10 Dec 2002 15:32:49 -0500
Date: Tue, 10 Dec 2002 21:40:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>, Pavel Machek <pavel@suse.cz>,
       Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com> <1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I concur with your pros and cons. This makes me think that if S4BIOS support
> > ever gets added, it should get added to 2.4 only.

And S4BIOS will never get added to 2.4 since it needs driver model
:-(.

> That assumes no box exists where S4bios works an S4 doesnt (eg due to
> bad tables or "knowing" what other-os does)

We have full control over S4 (== swsusp), so we can fix that in most
cases.

S4BIOS is still little friendlier to the user -- no need to set up
swap partition and command line parameter, can't go wrong if you boot
without resume=, etc.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
