Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTKSVcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTKSVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:32:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1018 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263945AbTKSVct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:32:49 -0500
Date: Wed, 19 Nov 2003 22:32:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] document that udev isn't yet ready (fwd)
Message-ID: <20031119213237.GA16828@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial documentation patch forwarded below still applies (with a 
few lines offset) against 2.6.0-test9-mm4.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 8 Oct 2003 14:07:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>,
	Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] document that udev isn't yet ready

On Wed, Oct 08, 2003 at 09:30:21AM +0200, Andreas Jellinghaus wrote:
> On Tue, 07 Oct 2003 21:51:27 +0000, Greg KH wrote:
> > And remember, _I_ did not submit that patch to the kernel marking devfs
> > obsolete.  Other kernel developers did.  And for good reasons, which
> > have all been explained before.  Even if udev wasn't even written yet,
> > it would have been done.
> 
> "Note that devfs has been obsoleted by udev,"
> 
> Most people expect after reading that sentence, that udev can do the
> work devfs did for them. But udev is not ready to do that, even by
> far. Thats why people complain.
>...

The following trivial change to te help text should clarify it:

--- linux-2.6.0-test6-mm4/fs/Kconfig.old	2003-10-08 14:02:15.000000000 +0200
+++ linux-2.6.0-test6-mm4/fs/Kconfig	2003-10-08 14:03:33.000000000 +0200
@@ -784,7 +784,7 @@
 	  ptys, you will also need to enable (and mount) the /dev/pts
 	  filesystem (CONFIG_DEVPTS_FS).
 
-	  Note that devfs has been obsoleted by udev,
+	  Note that devfs will be obsoleted by udev
 	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
 	  It has been stripped down to a bare minimum and is only provided for
 	  legacy installations that use its naming scheme which is


> Regards, Andreas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

