Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWI1WSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWI1WSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWI1WSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:18:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58130 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932527AbWI1WSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:18:09 -0400
Date: Thu, 28 Sep 2006 18:18:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Olaf Hering <olaf@aepfle.de>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.18
In-Reply-To: <20060928220852.GA24043@aepfle.de>
Message-ID: <Pine.LNX.4.44L0.0609281815170.10847-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Olaf Hering wrote:

> On Wed, Sep 27, Greg KH wrote:
> 
> > Alan Stern:
> 
> >       usbcore: remove usb_suspend_root_hub
> 
> This change between -git8 and -git9 makes my keyboard unhappy:

Another example of a bug for which the fix hasn't yet gone upstream to 
Linus.  The -mm kernel should work.  It you want to apply the fix 
yourself, it's these two patches:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115921335306280&w=2
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115921335520143&w=2

Alan Stern

