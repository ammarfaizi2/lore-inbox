Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTDJJSj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 05:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTDJJSj (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 05:18:39 -0400
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:64399
	"EHLO cygne") by vger.kernel.org with ESMTP id S264012AbTDJJSj (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 05:18:39 -0400
Message-ID: <41735.62.253.198.200.1049949087.squirrel@www.masroudeau.com>
Date: Thu, 10 Apr 2003 05:31:27 +0100 (BST)
Subject: Re: 2.5.66 Unable to update partition table
From: etienne.lorrain@masroudeau.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not able to update partition table with 2.5.66.
> I get following error message when I try to create a new partition.
>
> WARNING: Re-reading the partition table failed with error 16: Device or
> resource busy.
> The kernel still uses the old table.
> The new table will be used at the next reboot.
> Syncing disks.
>
> [root@elm3b78 root]# df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> ...
> /dev/sdb5             16476952  10891916   4748052  70% /home
> ...
>
> [root@elm3b78 root]# fdisk /dev/sdb
>
> Any ideas on why ? Is this expected ?

 Aren't you trying to modify the partition table of a hard disk
 while some of its partition are still mounted, are you?

  Etienne.
