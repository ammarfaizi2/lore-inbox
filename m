Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUGUGpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUGUGpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUGUGpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:45:08 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:13464 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S266163AbUGUGpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:45:05 -0400
Date: Wed, 21 Jul 2004 02:39:39 -0400
From: Greg KH <greg@kroah.com>
To: Russell Senior <seniorr@aracnet.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Oops 2.6.8-rc1 doing an rsync to USB mass storage
Message-ID: <20040721063939.GB21404@kroah.com>
References: <861xj62prs.fsf@coulee.tdb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861xj62prs.fsf@coulee.tdb.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 05:00:07PM -0700, Russell Senior wrote:
> 
> I am rsyncing from over a network to a locally attached USB2 Mass
> Storage external 200gig IDE drive in an ADS Technologies enclosure.
> Locks up the box solid, can't ping, can't SysRq anything.  I've seen
> this on two different IDE drives and enclosures, and also a similar
> but uncaptured Oops under 2.6.7 (whereupon I tried 2.6.8-rc1).

Can you try 2.6.8-rc2?  It has some usb fixes in it that might help
here.

thanks,

greg k-h
