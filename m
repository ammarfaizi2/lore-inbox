Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbVLGVbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbVLGVbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbVLGVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:31:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12814 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751784AbVLGVbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:31:34 -0500
Date: Wed, 7 Dec 2005 21:31:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207213128.GM6793@flint.arm.linux.org.uk>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133990886.6184.2.camel@bip.parateam.prv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:28:05PM +0100, Xavier Bestel wrote:
> Le mercredi 07 d?cembre 2005 ? 21:15 +0000, Russell King a ?crit :
> 
> > 4. User tries the well documented "setserial /dev/ttyS2 port 0x220 irq 5"
> >    procedure, which has been supported since Linux 1.x
> > 
> > 5. User finds that, because there is no ttyS2 device in /dev, they
> >    can't configure their card.
> 
> Well, instead of polluting everybody's /dev for the 3 users having such
> cards, why not just tell the user to run
> MAKEDEV /dev/ttyS2 ; setserial /dev/ttyS2 port 0x220 irq 5
> instead ? (Or even mknod)

Oh sorry.  Mail me your root password and IP address, let me log in
to your system, and I'll remove those device nodes right now.  Thanks
for pointing that out.

Seriously, surely you aren't suggesting that I somehow have personal
control over this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
