Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSJCV23>; Thu, 3 Oct 2002 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJCV23>; Thu, 3 Oct 2002 17:28:29 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:57634 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261364AbSJCV21>; Thu, 3 Oct 2002 17:28:27 -0400
Message-Id: <m17xDXf-006hxpC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 21:52:12 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <20021003161320.GA32588@kroah.com> <Pine.GSO.4.21.0210031217430.15787-100000@weyl.math.psu.edu> <20021003163018.GC32588@kroah.com>
In-Reply-To: <20021003163018.GC32588@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All devices that have a "struct device" (which should be about
> everything these days, if not, please let me know), cause a
> /sbin/hotplug event to happen.  This event says what type of device was
> added or removed, and includes the location of the device in the
> driverfs tree so that userspace can then determine what it wants to do
> with this device.

device != medium
There's a need to report that as well. The current hotplugging model
needs some more types of events before it is ready for all types of
applications.
In fact a change of medium can radically alter features of a device,
eg. from ro to rw.

	Regards
		Oliver
