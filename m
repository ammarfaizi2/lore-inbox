Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267573AbUBSVkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUBSVh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:37:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:36616 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267317AbUBSVf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:35:57 -0500
Date: Thu, 19 Feb 2004 21:35:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: linux-hotplug-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219202852.GB14549@kroah.com>
Message-ID: <Pine.LNX.4.44.0402192135360.26894-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Okay. If I change the major number of serial ttys inside the kernel 
> > of course udev would properly handle this. Now the question is would this 
> > break userland applications using the serial port?
> 
> Userland apps use /dev names, not major:minor number pairs, right?  So
> userspace should be just fine as long as you tell it the proper /dev
> name to use.

Just want to make sure. 

