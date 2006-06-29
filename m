Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWF2HZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWF2HZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWF2HZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:25:12 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:58634 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751713AbWF2HZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:25:11 -0400
Date: Thu, 29 Jun 2006 03:24:54 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Kconfig: Typos in fs/Kconfig
Message-Id: <20060629032454.f5e941f7.laplam@rpi.edu>
In-Reply-To: <20060629002036.ef53a483.rdunlap@xenotime.net>
References: <20060629020052.f73d7ca1.laplam@rpi.edu>
	<20060629002036.ef53a483.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 03:25:04 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 03:25:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 00:20:36 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Thu, 29 Jun 2006 02:00:52 -0400 Matt LaPlante wrote:
> 
> > Fix several typos in fs/Kconfig
> > 
> > -
> > --- b/fs/Kconfig	2006-06-29 01:35:36.000000000 -0400
> > +++ a/fs/Kconfig	2006-06-29 01:58:52.000000000 -0400
> > @@ -69,7 +69,7 @@
> >  	default y
> >  
> >  config EXT3_FS
> > -	tristate "Ext3 journalling file system support"
> > +	tristate "Ext3 journaling file system support"
> 
> Some dictionaries spell it either way, but it should be spelled
> consistently (see 3 lines below).

You are correct, I went with the above since it did appear below and was the default in my references.  We can always swap and change the below.

> 
> >  	select JBD
> >  	help
> >  	  This is the journaling version of the Second extended file system
> 
> > @@ -1059,13 +1059,13 @@
> >  	  to be made available to the user in the /proc/fs/jffs/ directory.
> >  
> >  config JFFS2_FS
> > -	tristate "Journalling Flash File System v2 (JFFS2) support"
> > +	tristate "Journaling Flash File System v2 (JFFS2) support"
> >  	select CRC32
> >  	depends on MTD
> >  	help
> > -	  JFFS2 is the second generation of the Journalling Flash File System
> > +	  JFFS2 is the second generation of the Journaling Flash File System
> >  	  for use on diskless embedded devices. It provides improved wear
> > -	  levelling, compression and support for hard links. You cannot use
> > +	  leveling, compression and support for hard links. You cannot use
> 
> either spelling is OK.

This was my error, I tried to use at least two sources for the others but in this case apparently my initial spell checker was ignorant and I forgot to check elsewhere.  Can be left as is.

> 
> >  	  this on normal block devices, only on 'MTD' devices.
> >  
> >  	  Further information on the design and implementation of JFFS2 is
> 
> ---
> ~Randy
> 

-
Matt

