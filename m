Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTLWWTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTLWWTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:19:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:64235 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262864AbTLWWTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:19:08 -0500
Date: Tue, 23 Dec 2003 14:13:41 -0800
From: Greg KH <greg@kroah.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
Message-ID: <20031223221341.GF15946@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com> <20031222092329.GA30235@kroah.com> <1072090725.1225.19.camel@descent.netsplit.com> <20031222204024.GF3195@kroah.com> <1072164547.1225.25.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072164547.1225.25.camel@descent.netsplit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 07:29:07AM +0000, Scott James Remnant wrote:
> On Mon, 2003-12-22 at 20:40, Greg KH wrote:
> 
> > On Mon, Dec 22, 2003 at 10:58:45AM +0000, Scott James Remnant wrote:
> > > One question though, it only ever seems to create a device for the
> > > actual usb-storage disk and not the partition.  Is there some magic to
> > > create the partition device instead?
> > 
> > Do you have a partition show up in /sys/block?  If not, then udev will
> > not create it.  It works here for my usb-storage devices that have
> > partitions on them.
> > 
> Yes, /dev/block/sdb/sdb1 certainly does appear, as does /udev/sdb1 --
> the LABEL rule only seems to match "sdb" though.

That's odd, what is the rule?  They should both match.

greg k-h
