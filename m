Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSJCVhS>; Thu, 3 Oct 2002 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSJCVhD>; Thu, 3 Oct 2002 17:37:03 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:17165 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261352AbSJCVgZ>;
	Thu, 3 Oct 2002 17:36:25 -0400
Date: Thu, 3 Oct 2002 14:39:08 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: [BK PATCH] minor devfs cleanup for 2.5.40
Message-ID: <20021003213908.GB1388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a changeset from Christoph Hellwig that removes some unneeded
code from the kernel core.  This was leftover from before devfs became
part of the main kernel tree, and was trying to do some naming fixups in
kernelspace.  If anyone still has machines using these names, their
startup scripts should be modified to use the "standard" devfs names.

Please pull from:  http://linuxusb.bkbits.net/devfs-2.5

thanks,

greg k-h

 init/do_mounts.c |   58 -------------------------------------------------------
 1 files changed, 58 deletions(-)
-----

ChangeSet@1.683, 2002-10-03 13:58:19-07:00, hch@sgi.com
  [PATCH] Remove some more devfs crap
  
  Translation code for old devfs names that _never_ were in mainline
  for root=.

 init/do_mounts.c |   58 -------------------------------------------------------
 1 files changed, 58 deletions(-)
------

