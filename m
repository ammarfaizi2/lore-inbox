Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbSLEVM2>; Thu, 5 Dec 2002 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbSLEVEE>; Thu, 5 Dec 2002 16:04:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4868 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267385AbSLEU5z>;
	Thu, 5 Dec 2002 15:57:55 -0500
Date: Thu, 5 Dec 2002 18:06:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] ACPI updates
Message-ID: <20021205170640.GA731@elf.ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A56D@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A56D@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > From: Arjan van de Ven [mailto:arjanv@redhat.com] 
> > > Is your concern with the code, or the cmdline option? We 
> > could certainly
> > 
> > the code, not so much the commandline option (that one is not used
> > in practice), but actually my biggest concern is that you 
> > break existing
> > setups, or at least change it more than needed. There is ZERO need to
> > remove the existing working (and lean) code, even though your 
> > code might
> > also be able to do the same. It means people suddenly need to 
> > change all
> > kinds of config options, it's different code so will work slightly
> > different... unifying 2.5 is nice and all but there's no need for that
> > here since both implementations can coexist trivially (as the 
> > United Linux
> > kernel shows)
> 
> Well maybe that's what we should do - use the UnitedLinux ACPI patch (which
> iirc is based on fairly recent ACPI code, and presumably minimizes
> ACPI-related breakage) and then proceed incrementally from there?
> 
> Sound OK? Marcelo? UL folks?
> 
> Regards -- Andy
> 
> PS probably involve some work breaking out the ACPI stuff from the UL patch
> as a whole, or maybe (???) the UL people already have it broken out?

I guess it will be better if you push acpi patch without killing those
backup solutions. Extractign blacklist from UL might be worth it,
through.
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
