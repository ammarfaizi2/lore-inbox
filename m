Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSCLXOw>; Tue, 12 Mar 2002 18:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCLXNd>; Tue, 12 Mar 2002 18:13:33 -0500
Received: from p508879CE.dip.t-dialin.net ([80.136.121.206]:2691 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S289817AbSCLXNS>; Tue, 12 Mar 2002 18:13:18 -0500
Date: Wed, 13 Mar 2002 00:13:08 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Message-ID: <20020312231308.GD1108@darkside.ddts.net>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CDE@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CDE@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 03:05:04PM -0800, Grover, Andrew wrote:
> Well sure, you can work around this bug on your particular machine, but I
> can't do the same because then, unlike your machine where not enough devices
> are enabled for wake, *too many* devices will be enabled for wake on some
> machines. This results in them not turning off properly -- they come right
> back on. ;-)

Okay, I understand this part :)

But what's with the more important one? Isn't that simply readable
from the BIOS somehow?
Doesn't store the BIOS the devices used for ACPI wakeup somewhere
in the ACPI tables?
Can't one read them out there?

And if not - is there actually a syscall interface where i can reach
acpi_hw_enable_gpe_for_wakeup()?
And if so - how can I translate devices to GPE numbers?


thanks & regards,
   Mario
-- 
[mod_nessus for iauth]
<delta> "scanning your system...found depreciated OS...found
        hole...installing new OS...please reboot and reconnect now"
