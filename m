Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSBGNXt>; Thu, 7 Feb 2002 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288238AbSBGNXj>; Thu, 7 Feb 2002 08:23:39 -0500
Received: from ns.suse.de ([213.95.15.193]:9221 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282511AbSBGNXf>;
	Thu, 7 Feb 2002 08:23:35 -0500
Date: Thu, 7 Feb 2002 14:23:33 +0100
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020207142333.A22451@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Patrick Mochel <mochel@osdl.org>,
	Andre Hedrick <andre@linuxdiskcert.org>,
	Russell King <rmk@arm.linux.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020206122253.GB446@elf.ucw.cz> <E16YcaF-0006z9-00@the-village.bc.nu> <20020207123125.GF5247@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020207123125.GF5247@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Thu, Feb 07, 2002 at 01:31:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 01:31:25PM +0100, Pavel Machek wrote:
 > > I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac 
 > > perfectly ready for a 2.5 merger
 > PnPBIOS is nasty, and I suspect it is not present/working on all
 > models, right?

 For the most part it's fine, it just needs the floppy driver / ps2
 driver (and maybe some others) fixed up to not allocate regions
 that pnpbios already reserved. Other than these issues, it seems
 to be working well. It's certainly handled itself ok on all my
 test boxes (Even the weird compaq with the fscked up pnpbios --
 it claims to have pnpbios, yet when you call it, you get feature
 not supported return codes. cute.)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
