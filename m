Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSBGNEh>; Thu, 7 Feb 2002 08:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291049AbSBGNE2>; Thu, 7 Feb 2002 08:04:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16389 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287769AbSBGNEK>; Thu, 7 Feb 2002 08:04:10 -0500
Date: Thu, 7 Feb 2002 14:03:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020207130359.GI5247@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020206122253.GB446@elf.ucw.cz> <Pine.LNX.4.33.0202061502290.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202061502290.25114-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If the IDE controller doesn't know it's parent, create an 'ide' bus as a 
> child of the root and put ide devices under it. If there are multiple 
> controllers or channels, represent them accordingly. 

Uh?

I'd expect legacy bus (it fits description of legacy device, right?)
and then ide bus hanging from the IDE controller on legacy bus, then
disks on the ide bus...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
