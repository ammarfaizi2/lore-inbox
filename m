Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbVLGVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbVLGVjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbVLGVjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:39:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49170 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751796AbVLGVjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:39:02 -0500
Date: Wed, 7 Dec 2005 21:38:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>, Jason Dravet <dravet@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207213856.GN6793@flint.arm.linux.org.uk>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv> <20051207213128.GM6793@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207213128.GM6793@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:31:28PM +0000, Russell King wrote:
> On Wed, Dec 07, 2005 at 10:28:05PM +0100, Xavier Bestel wrote:
> > Le mercredi 07 d?cembre 2005 ? 21:15 +0000, Russell King a ?crit :
> > 
> > > 4. User tries the well documented "setserial /dev/ttyS2 port 0x220 irq 5"
> > >    procedure, which has been supported since Linux 1.x
> > > 
> > > 5. User finds that, because there is no ttyS2 device in /dev, they
> > >    can't configure their card.
> > 
> > Well, instead of polluting everybody's /dev for the 3 users having such
> > cards, why not just tell the user to run
> > MAKEDEV /dev/ttyS2 ; setserial /dev/ttyS2 port 0x220 irq 5
> > instead ? (Or even mknod)
> 
> Oh sorry.  Mail me your root password and IP address, let me log in
> to your system, and I'll remove those device nodes right now.  Thanks
> for pointing that out.
> 
> Seriously, surely you aren't suggesting that I somehow have personal
> control over this?

Additionally, if you have a problem with this, the total number of
ports _is_ kernel configurable.

So if you're getting 32 ports from a distro targetted at the current
range of consumer hardware which commonly has maybe 1 or 2 and
possibly a modem card (iow probably max 4 ports), please take it up
with them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
