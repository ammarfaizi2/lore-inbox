Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTL1DLT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTL1DLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:11:19 -0500
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:58619 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S264949AbTL1DLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:11:13 -0500
Subject: Re: 2.7 (future kernel) wish
From: Rob Love <rml@ximian.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FEE47F5.6090406@why.dont.jablowme.net>
References: <200312232342.17532.josh@stack.nl>
	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com>
	 <1072507896.27022.226.camel@menion.home>
	 <3FEE47F5.6090406@why.dont.jablowme.net>
Content-Type: text/plain
Message-Id: <1072581073.4042.10.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 27 Dec 2003 22:11:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 22:03, Jim Crilly wrote:

> Generally it just complains that you pulled out the device prematurely, 
> I've never seen one give a STOP error from that but I guess a bad driver 
> or USB controller could cause anything.

It would be pretty easy to screw things up if you pull out a device in
the middle of use.

> When you insert a device like a USB stick Windows puts a little icon 
> next to the clock in the system tray that you're supposed to use to stop 
> the device before pulling it, effectively it unmounts and stops (or 
> atleast releases the device from) the driver so the device can be 
> 'safely' removed.

This is useful, and something I think we need on the Linux desktop (stay
tuned).

> I also believe Windows mounts any removable device 
> synchronously so that if you do pull it out prematurely the damage done 
> is limited.

Eww, I hope not, that would be excruciatingly slow.  It might adjust the
buffer writeback to be really short (even nearly immediate) but
synchronous I/O is a different story, and much slower.

	Rob Love


