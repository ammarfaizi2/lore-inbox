Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVJZAKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVJZAKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJZAKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:10:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:520 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932498AbVJZAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:10:38 -0400
Date: Wed, 26 Oct 2005 01:10:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@cantab.net>
Cc: Ben Dooks <ben@fluff.org.uk>, Pavel Machek <pavel@ucw.cz>,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sharp zaurus: prevent killing spitz-en
Message-ID: <20051026001027.GA25420@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@cantab.net>,
	Ben Dooks <ben@fluff.org.uk>, Pavel Machek <pavel@ucw.cz>,
	rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
References: <20051025190829.GA1788@elf.ucw.cz> <20051025225815.GA31679@home.fluff.org> <435EBD56.70601@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435EBD56.70601@cantab.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 12:18:46AM +0100, David Vrabel wrote:
> Ben Dooks wrote:
> >It would be better for each machine to export an config option
> >from the Kconfig to specify if they have a maximum size.
> 
> Isn't the maximum size a property of the bootloader/other firmware? 
> i.e., something the kernel build system knows nothing about.

Yes.  blob, for instance, aborts an xmodem download if it's too large.
The kernel has no knowledge of what blob classifies as "too large"
which may indeed be different from uboot, bootldr, redboot, or ...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
