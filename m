Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDUJJo>; Sat, 21 Apr 2001 05:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDUJJf>; Sat, 21 Apr 2001 05:09:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132539AbRDUJJ3>;
	Sat, 21 Apr 2001 05:09:29 -0400
Date: Sat, 21 Apr 2001 10:09:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@transmeta.com>,
        linux-power@phobos.fachschaften.tu-muenchen.de
Subject: Re: PCI power management
Message-ID: <20010421100913.A7433@flint.arm.linux.org.uk>
In-Reply-To: <3AE02E45.57D7BA9D@mandrakesoft.com> <20010420125615.23599@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010420125615.23599@mailhost.mipsys.com>; from benh@kernel.crashing.org on Fri, Apr 20, 2001 at 02:56:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 02:56:15PM +0200, Benjamin Herrenschmidt wrote:
> It's not so complicated to have the minimum flexibility for the driver
> to tell it's maximum supported power level, and I don't see why it would
> be a problem to use D2 instead of D3 when we don't support D3 for a given
> device (either because the HW is broken, undocumented, or because our
> driver just don't know how to bring back the chip to life).

Umm, isn't it true that most VGA cards will have this problem?  Are we
going to put an x86 emulator into the kernel so we can run the BIOS on
non-x86 hardware, just so that we can re-initialise the chip? ;|

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

