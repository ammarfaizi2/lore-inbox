Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWACUee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWACUee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWACUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:34:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:144 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932328AbWACUed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:34:33 -0500
Date: Tue, 3 Jan 2006 15:34:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: dtor_core@ameritech.net, <dmitry.torokhov@gmail.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: usb: replace __setup("nousb") with
 __module_param_call
In-Reply-To: <20060103113533.6ac3e351.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0601031530490.18243-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Pete Zaitcev wrote:

> On Tue, 3 Jan 2006 09:46:26 -0500, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > But even if it does, my patch saved reading, so I think it should be
> > > applied as well.
> > 
> > What you mean by "saved reading"?
> 
> The diffstat was almost all dashes: 13 deletions, 1 addition.
> 
> > Btw, do we really need to export "nousb" in sysfs?
> 
> Nobody would die if we didn't, but there's nothing wrong with the idea
> in general. At least you'd know that the parameter was actually parsed.
> I wish usb-handoff was exported similarly, because there's absolutely
> no way to tell if it worked or was quietly ignored. And I abhor printks
> in normal or success cases, so I do not want such indication.

usb-handoff no longer exists.  The kernel now takes USB host controllers
away from the BIOS as soon as they are discovered.

Alan Stern

