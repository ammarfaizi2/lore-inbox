Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVECDOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVECDOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVECDOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:14:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:10142 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261333AbVECDO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:14:28 -0400
Date: Mon, 2 May 2005 20:14:21 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050503031421.GA528@kroah.com>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e6005050219514ece0c0a@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 10:51:24PM -0400, Joe wrote:
> Ok, first off I'd like to say, I am on 2.6.12-rc3-mm2, and this issue
> is not fixed at all.  Secondly, I'd like to say that I've pinpointed
> it a bit more.  It appears only Empty partitions (type 0 in fdisk) do
> not create device nodes.
> 
> Here is the partition table from fdisk, fdisk does run fine.. its just
> the fact this node is not created that threw me off before.
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdb1   *           1           2       16033+   0  Empty
> /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> /dev/sdb3               3           5       24097+  83  Linux
> 
> 
> Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> sdb2, and sdb3.  No sdb1.  Any help would be appreciated.

Looks like it might be a scsi issue.  Redirecting to that mailing list
now.  Anyone here have a clue?

thanks,

greg k-h
