Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULTPeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULTPeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbULTP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:29:29 -0500
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261545AbULTP2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:28:05 -0500
Date: Mon, 20 Dec 2004 10:28:05 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Ed Tomlinson <edt@aei.ca>
cc: Pete Zaitcev <zaitcev@redhat.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
In-Reply-To: <200412200702.50071.edt@aei.ca>
Message-ID: <Pine.LNX.4.44L0.0412201026390.1358-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Ed Tomlinson wrote:

> Its not that they just enable it.  Its that it has side effects.  I enable it to support
> one device - it then 'devnaps' other devices that usbstorage supports _much_
> better.  Is there some way it could work in reverse.  eg. let ub bind only if 
> usbstorage does not, possibly making usbstorage a _little_ more conservative
> if ub is present?

Unfortunately there isn't any way to define which driver should bind to a 
device, if they are both capable of controlling it.  Maybe there should 
be.  It might not be too hard to add a sysfs interface for that sort of 
thing.

Alan Stern

