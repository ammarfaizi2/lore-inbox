Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUBSIBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266936AbUBSIBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:01:14 -0500
Received: from ns.schottelius.org ([213.146.113.242]:19371 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S266721AbUBSIBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:01:13 -0500
Date: Thu, 19 Feb 2004 09:01:15 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
Message-ID: <20040219080115.GD25184@schottelius.org>
References: <200402160109.05151.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.21.0402181042090.8134-100000@dirac.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0402181042090.8134-100000@dirac.phys.uwm.edu>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Allen [Wed, Feb 18, 2004 at 10:55:05AM -0600]:
> [...] 
> FWIW, after reading this thread, I've slightly modified smartmontools so
> that when smartctl prints the error log (-l error) it ALSO prints the LBA
> at which a READ or WRITE command failed.

Thank you very much for patching smartctl and explaining howto calulate
the LBA from those values.

So at least my hd crash had some sense.

> [Note that this is a 28-bit sector address.  If a disk is larger than 2^37
> Bytes = 137 GB, then some LBAs can't be written in 28 bits, in which case
> there won't be a summary error log entry.  If the disk is smaller than
> 2^37 Bytes then the failing LBA address should always be logged.]

Why are we bound to a 28 bit value?
As there are currently more and more disks out there with >=260GB, I
think this will be an issue very soon.

Have a nice day,

Nico, currenty working with knoppix, a wonderful live Linux
                           (www.knopper.net/knoppix)

