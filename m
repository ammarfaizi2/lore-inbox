Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUFRJN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUFRJN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFRJKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:10:31 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:44732 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S265065AbUFRJJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:09:17 -0400
Subject: Re: more files with licenses that aren't GPL-compatible
From: Adrian Cox <adrian@humboldt.co.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Erik Harrison <erikharrison@gmail.com>, davids@webmaster.com,
       eric@cisu.net, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040616224949.GB7932@hh.idb.hist.no>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com>
	 <5b18a542040616133415bf54d1@mail.gmail.com>
	 <20040616224949.GB7932@hh.idb.hist.no>
Content-Type: text/plain
Message-Id: <1087549710.1547.14.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 10:08:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 23:49, Helge Hafting wrote:

> 1. don't _link_ the proprietary file into the kernel, ship firmware & logo
> as separate files along with the distro.  No problem.

USB serial drivers could be implemented in userspace given a 2.6 version
of Rogier Wolff's userspace serial patch:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/att-1075/01-patch-2.4.20.trueport-12-mrt

We currently have a lot of USB drivers in the kernel that could be 
implemented in userspace. I'm thinking of drivers/usb/image, misc, and
serial particularly. If there was a userspace API to do for video
capture what SANE does for scanners, drivers/usb/media would be mostly
unneeded as well.

If vendors noticed that this was possible, we'd probably get more binary
userspace drivers for USB devices. I pass no judgement here as to
whether this would be good or bad.

- Adrian Cox
Humboldt Solutions Ltd.


