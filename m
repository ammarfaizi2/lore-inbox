Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWACUws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWACUws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWACUws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:52:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34236 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932420AbWACUwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:52:47 -0500
Date: Tue, 3 Jan 2006 15:52:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Pete Zaitcev <zaitcev@redhat.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: usb: replace __setup("nousb") with
 __module_param_call
In-Reply-To: <d120d5000601031238x4db9999eyc6358d2a010ad9dd@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0601031549130.18243-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Dmitry Torokhov wrote:

> On 1/3/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > usb-handoff no longer exists.  The kernel now takes USB host controllers
> > away from the BIOS as soon as they are discovered.
> >
> 
> Yes! YES! YEEEEES!
> 
> *Dmitry dances and rejoices*

It may not be totally advantageous.  Sometimes people have trouble with
system installs, when for some reason the USB HID driver doesn't work.  
If you've got a USB keyboard now you're pretty well stuck, whereas in the
past you could specify "nousb" and the BIOS would continue to drive the
keyboard.

Alan Stern

