Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVKBP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVKBP4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVKBP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:56:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:1927 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965102AbVKBP4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:56:08 -0500
Date: Wed, 2 Nov 2005 10:56:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: matthieu castet <castet.matthieu@free.fr>,
       <linux-usb-devel@lists.sourceforge.net>, <usbatm@lists.infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [PATCH]  Eagle and ADI 930 usb adsl modem
 driver
In-Reply-To: <20051101224510.GB28193@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0511021051200.4928-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Greg KH wrote:

> > +/* we need to use semaphore until sysfs and removable devices is fixed
> > + * the problem is explained on http://marc.theaimsgroup.com/?t=112006484100003
> > + */
> 
> This is the proper fix, why do you think it should be fixed in the
> driver core?

I missed the earlier discussion about this when it appeared on lkml.

This is no doubt a widespread problem, and it should be brought to many 
people's attention.  Greg, can you think of any good way to make this more 
visible?  Maybe a short piece in Linux Journal combined with a more 
eye-catching $SUBJECT in lkml?

Maybe this could be combined with a brief discussion of the open-remove 
race as well (and the use of BKL to help resolve it).

Alan Stern

