Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTDVVSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263878AbTDVVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:18:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1242 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263875AbTDVVSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:18:45 -0400
Date: Tue, 22 Apr 2003 14:32:47 -0700
From: Greg KH <greg@kroah.com>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: Re: PATCH: some additional unusual_devs-entries for usb-storage-driver, kernel 2.5.68
Message-ID: <20030422213247.GA5076@kroah.com>
References: <20030421214805.7de5e4f3.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030421214805.7de5e4f3.hanno@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 09:48:05PM +0200, Hanno Böck wrote:
> This patch against 2.5.68 adds support for some digital cameras.
> Same patch is already applied to the 2.4-ac-series.
> It is taken from the lycoris kernel-source.

Ok, in talking with the usb-storage author, I'll be accepting all
unushal_devs.h patches now, as long as they contain the following:
	- a comment above the entry with a email address of someone who
	  has this device that this entry fixes the driver for them.
	  This is to allow us to possibly remove entries at a later time
	  if the core changes, and get a verification that it's ok to do
	  so.
	- a copy of the /proc/bus/usb/devices device entry with the
	  device plugged in and the driver loaded (this should not be in
	  the patch, but in the body of the email.)
	  
So, if there are any outstanding drivers/usb/storage/unusual_devs.h
entries that people have floating around, sent them on!

thanks,

greg k-h

