Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263825AbRFFRXb>; Wed, 6 Jun 2001 13:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFFRXL>; Wed, 6 Jun 2001 13:23:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35086 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263669AbRFFRXC>;
	Wed, 6 Jun 2001 13:23:02 -0400
Date: Wed, 6 Jun 2001 18:22:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010606182221.B30546@flint.arm.linux.org.uk>
In-Reply-To: <20010606125556.A1766@suse.cz> <3B1E5AE0.9202DD00@mandrakesoft.com> <20010606190158.A2010@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606190158.A2010@suse.cz>; from vojtech@suse.cz on Wed, Jun 06, 2001 at 07:01:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 07:01:58PM +0200, Vojtech Pavlik wrote:
> On Wed, Jun 06, 2001 at 12:31:28PM -0400, Jeff Garzik wrote:
> > hmmm.  I just looked over this, and drivers/char/joystick/ser*.[ch].
> > 
> > Bad trend.
> > 
> > Serial needs to be treated just like parport: the basic hardware code,
> > then on top of that, a selection of drivers, all peers:  dumb serial
> > port, serial mouse, joystick, etc.
> 
> Agreed. Completely.

I suggest that if someone is thinking about this that they look at
serial_core.c in the ARM patch hunk.
   (ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v2.4/)

Note that you shouldn't apply the whole patch - it probably won't compile
for anything but ARM atm.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

