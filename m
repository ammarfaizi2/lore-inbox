Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311271AbSC1BKj>; Wed, 27 Mar 2002 20:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311273AbSC1BK3>; Wed, 27 Mar 2002 20:10:29 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:24582 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311271AbSC1BKU>;
	Wed, 27 Mar 2002 20:10:20 -0500
Date: Wed, 27 Mar 2002 17:10:19 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7-gregkh-1  (USB stuff)
Message-ID: <20020328011019.GD5878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 27 Feb 2002 22:10:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a lot of different USB patches that have gone into my
tree since 2.5.7 came out, so here's a big patch with all of them for
people to play with, and resync against.

It's available at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/linux-2.5.7-gregkh-1.patch.bz2

and contains the following changes:

 - USB Serial console support			(me and Randy Dunlap)
 - USB core sanity check			(David Brownell)
 - ohci-hcd driver update			(David Brownell)
 - uhci bugfixes				(Johannes Erdfelt)
 - added Palm i705 support to visor driver	(me)
 - hiddev cleanup and documentation update	(Paul Stewart)
 - rtl8150 USB ethernet driver added		(Petko Manolov)
 - pegasus driver bugfixes			(Petko Manolov)
 - USB serial core logic changes		(me)
 - USB serial driver changes for last change	(me)
 - added Palm m130 support to visor driver	(me)
 - changed hub startup check interval to play
   nicer with some devices			(Itai Nahshon)
 - hpusbscsi driver updates			(Oliver Neukum)
 - usbfs periodic endpoing/bandwidth reporting
   fixes					(David Brownell)
 - ipaq driver updates				(Ganesh Varadarajan)
 - proc_usb_info.txt update			(David Brownell)
 - ehci-hcd driver update			(David Brownell)
 - hcd bugfix					(David Brownell)
 - added more printers to the quirks list	(David Paschal)

If anyone has any problems with this patch, please let me know.

thanks,

greg k-h
