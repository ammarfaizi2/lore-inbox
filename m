Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272057AbTHOWh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272135AbTHOWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:37:27 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:18695 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272057AbTHOWhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:37:24 -0400
Date: Fri, 15 Aug 2003 23:37:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Otto Solares <solca@guug.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
In-Reply-To: <20030814231620.GA4632@kroah.com>
Message-ID: <Pine.LNX.4.44.0308152337070.30952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is there an API (or lib) to use framebuffers devices without
> > worring about differents visuals?, to quering, setting or
> > disabling EDID support? will these drivers export sysfs
> > entries instead of control via ioctl's?
> 
> I have some initial sysfs patches for the fb code that I've been sitting
> on in my trees.  I was waiting for these patches to hit the mainline
> before bothering James and the rest of the world with them.
> 
> But they don't export any of the ioctl stuff through the sysfs
> interface, but that would not be very hard to do at all if you want to.
> They just basically show the major/minor of the fb device, and point
> back to the proper place in the device tree where the fb device lives,
> which is all udev really needs right now.

Could you send me those patches :-)

