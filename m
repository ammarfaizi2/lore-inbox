Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSEHXAk>; Wed, 8 May 2002 19:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315494AbSEHXAj>; Wed, 8 May 2002 19:00:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:9991 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315487AbSEHXAi>;
	Wed, 8 May 2002 19:00:38 -0400
Date: Wed, 8 May 2002 15:00:41 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] pcihpview 0.3
Message-ID: <20020508220041.GA13129@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 10 Apr 2002 20:28:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I've made a few small changes to the PCI Hotplug GUI tool (called
pcihpview) and released a new version of it.  I also built some .rpm
packages, to try to alleviate some of the problems people were having
when building from the tarball.

The files can be found at:
 	http://www.kroah.com/linux/hotplug/pcihpview-0.3.tar.gz
 	http://www.kroah.com/linux/hotplug/pcihpview-0.3-1.i386.rpm
 	http://www.kroah.com/linux/hotplug/pcihpview-0.3-1.src.rpm

More info on the program (but not much), and the obligatory screenshot
can be found at:
	http://www.kroah.com/linux/hotplug/

The changelog entries for this version are:
	- added pcihpview.spec file so we can build rpms
	- added logging.c and logging.h to move logging messages to the
	  syslog
	- moved printk() calls to dbg().
	- added Refresh menu option.

Things that will be changing in the future are:
	- autorefresh for when slot status changes without user
	  interaction (needed when using the ACPI PCI Hotplug driver.)
	- user interface cleanups.

If anyone has any problems with the program, please let me know.

thanks,

greg k-h
