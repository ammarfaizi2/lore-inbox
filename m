Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUDJVEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUDJVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 17:04:52 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:62481 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262113AbUDJVEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 17:04:50 -0400
Date: Sat, 10 Apr 2004 23:04:45 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs
 dirty volume marking)
In-Reply-To: <20040410205445.GV31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0404102301400.840-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Apr 10, 2004 at 10:29:37PM +0200, Andries Brouwer wrote:
> > On Fri, Apr 09, 2004 at 01:38:51PM +0200, Szakacsits Szabolcs wrote:
> > 
> > > > TODO.ntfsprogs conatins the following TODO item under mkntfs:
> > > >  - We don't know what the real last sector is, thus we mark the volume
> > > > dirty and the subsequent chkdsk (which will happen on reboot into
> > > > Windows automatically) recreates the backup boot sector if the Linux
> > > > kernel lied to us about the number of sectors.
> > 
> > The ioctl BLKGETSIZE64 will tell you the size (in bytes) of a block device.
> 
> So will lseek() to SEEK_END, actually (both 2.4 and 2.6).
> And yes, last sector _is_ accessible for dd(1) et.al.

In 2.6? Not for 2.4 when I tried (it wasn't the latest 2.4 kernel).

	Szaka

