Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTC0WnF>; Thu, 27 Mar 2003 17:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbTC0WnE>; Thu, 27 Mar 2003 17:43:04 -0500
Received: from [81.2.110.254] ([81.2.110.254]:60152 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261476AbTC0WnD>;
	Thu, 27 Mar 2003 17:43:03 -0500
Subject: Re: 64-bit kdev_t - just for playing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303272245490.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
	 <Pine.LNX.4.44.0303272245490.5042-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 22:55:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 22:12, Roman Zippel wrote:
> How are these disks registered and how will the dev_t number look like?

Al Viro's work so far makes those issues you can defer nicely. 

> How will the user know about these numbers?

Devices.txt or dynamic assignment

> Who creates these device entries (user or daemon)?

Who cares 8)  Thats just the devfs argument all over again 8)

> SCSI has multiple majors, disks 0-15 are at major 8, disks 16-31 are at 
> 65, ...., disks 112-127 are at major 71. Will this stay the same? Where 
> are the disk 128-xxx?
> Can I have now more than 15 partitions?

It becomes possible, more importantly we can begin to support
partitioned CD-ROM both for multisession and for real partition
tables on CD (eg Macintrash)

