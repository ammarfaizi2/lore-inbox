Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVEFH7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVEFH7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 03:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEFH7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 03:59:00 -0400
Received: from pastinakel.tue.nl ([131.155.2.7]:29967 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261168AbVEFH6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 03:58:44 -0400
Date: Fri, 6 May 2005 09:58:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Joe <joecool1029@gmail.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050506075840.GC4604@pclin040.win.tue.nl>
References: <d4757e6005050219514ece0c0a@mail.gmail.com> <20050503031421.GA528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503031421.GA528@kroah.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 08:14:21PM -0700, Greg KH wrote:
> On Mon, May 02, 2005 at 10:51:24PM -0400, Joe wrote:
> > Ok, first off I'd like to say, I am on 2.6.12-rc3-mm2, and this issue
> > is not fixed at all.  Secondly, I'd like to say that I've pinpointed
> > it a bit more.  It appears only Empty partitions (type 0 in fdisk) do
> > not create device nodes.
> > 
> > Here is the partition table from fdisk, fdisk does run fine.. its just
> > the fact this node is not created that threw me off before.
> > 
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/sdb1   *           1           2       16033+   0  Empty
> > /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> > /dev/sdb3               3           5       24097+  83  Linux
> > 
> > 
> > Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> > sdb2, and sdb3.  No sdb1.  Any help would be appreciated.
> 
> Looks like it might be a scsi issue.  Redirecting to that mailing list
> now.  Anyone here have a clue?

Hmm - you even put this in 2.6.11.8, if I understand correctly.
Was that by mistake?
