Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280895AbRKKMHr>; Sun, 11 Nov 2001 07:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281042AbRKKMHh>; Sun, 11 Nov 2001 07:07:37 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:6092 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281032AbRKKMH1>; Sun, 11 Nov 2001 07:07:27 -0500
Date: Sun, 11 Nov 2001 12:07:20 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, lobo@polbox.com,
        linux-kernel@vger.kernel.org
Subject: [Very-OT] Re: Nazi kernels
In-Reply-To: <20011111005849.A26855@alcove.wittsend.com>
Message-ID: <Pine.SOL.3.96.1011111120107.21134C-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Michael H. Warfield wrote:
> 	Oh, but you missed the mark!  Think Windows XP.  Now there's
> the ticket.  If you aren't a Windows XP certified driver, they can
> just wipe your driver right off the face of the system...  All in the
> name of "stability" (as they define it).  None of this nonsense of
> merely flagging if their OS has a non-sanctified driver like Linux.
> Linux lets the driver load and run, it merely lets people KNOW that
> it's an un-sanctified driver when shit catches fire and burns.  You
> know MS.  MS thinks Linux is just a bunch of whimps.  Screw just letting
> the user know AFTER something burps and burns.  That's TOO complicated
> for a user to figure out and MS has to be "user friendly".  MS is for
> men with balls (and no brains)...  Just burn the driver BEFORE it has
> a chance to run.  Yeah!  That's the ticket!

Let's not get carried away. Windows XP does allow you to install anything
you like. You just have to click several times on the Yes button when it
asks things like "This driver is not XP certified. Do you really want to
use it?" and "Installing a non-certified driver can cause system
instability. Are you sure you want to do this?" (text is probably not
quite right but you get the idea).

I think we ought to do the same with closed source drivers. It's true
after all... The whole point of tainting the kernel is so we can just yell
at users to go and bug the vendor. So the modprobe executable could warn
the user "hey, you are loading a binary only module, it can break the
system, are you sure?". If the module is autoloaded we don't do jumping
through hoops asking questions so the systen runs smoothly.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

