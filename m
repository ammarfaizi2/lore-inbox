Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269353AbTCDKKS>; Tue, 4 Mar 2003 05:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbTCDKKR>; Tue, 4 Mar 2003 05:10:17 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S269353AbTCDKKE>;
	Tue, 4 Mar 2003 05:10:04 -0500
Date: Tue, 4 Mar 2003 14:23:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] S4bios support for 2.5.63
Message-ID: <20030304132329.GF618@zaurus.ucw.cz>
References: <20030226211347.GA14903@elf.ucw.cz> <20030227141322.GV13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227141322.GV13404@poup.poupinou.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > +
> > +	do {
> > +		acpi_os_stall(1000);
> > +		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
> 
> Please use ACPI_MTX_DO_NOT_LOCK flags.

Is s/MTX_LOCK/MTX_DO_NOT_LOCK/
enough?

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

