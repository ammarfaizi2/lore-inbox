Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWJHOc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWJHOc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWJHOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:32:27 -0400
Received: from mx2.rowland.org ([192.131.102.7]:45838 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751195AbWJHOc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:32:27 -0400
Date: Sun, 8 Oct 2006 10:32:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610081524.09946.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610081029420.17010-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2006, Oliver Neukum wrote:

> That's an important aspect. How about implementing autosuspend
> first and keeping the sysfs-based suspension for now? If autosuspend
> is done, we have something to compare too. If a different solution
> emerges to be advantagous under some conditions we can talk about
> the interface later.

Well, autosuspend for USB is on its way.  There are just a few bugs
remaining in my changes to ehci-hcd.  They should be ironed out soon and 
then Greg will merge it.

The existing sysfs power/state implementation isn't going away
immediately.  It is deprecated and scheduled for removal in July 2007.

Alan Stern

