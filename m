Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTLOIxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTLOIxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:53:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40603 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263388AbTLOIxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:53:14 -0500
Date: Mon, 15 Dec 2003 09:53:12 +0100
From: Jan Kara <jack@suse.cz>
To: Bobby Hitt <Robert.Hitt@bscnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need Quota Support for Reiserfs Partition
Message-ID: <20031215085312.GD6613@atrey.karlin.mff.cuni.cz>
References: <01a901c3c2a7$f5d8a9d0$0900a8c0@BOBHITT>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a901c3c2a7$f5d8a9d0$0900a8c0@BOBHITT>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I'm using Slackware Linux with kernel version 2.6.0-test11. All of my
> partitions are Rieserfs. I now have a need to use quotas on a partition, but
> according to the help screen using "make menuconfig" quotas are only
> available under the ext2 file systems. Is there a patch to allow quotas
> under rieserfs? One of my searches said that Reiserfs and quotas were
> supported under 2.6.0, but when I try and mount the partition with this line
> in /etc/fstab:
> 
> /dev/hde2 /downloads reiserfs defaults,usrquota,grpquota 1 2
> 
> I get this error:
> 
> mount: wrong fs type, bad option, bad superblock on /dev/hde2,
>        or too many mounted file systems
> 
> 
> If I take the usrquota,grpquota off, the mount works fine.
  AFAIK ReiserFS doesn't support quotas in 2.6 kernel. Chris Mason
<mason@suse.com> maintains needed patches for 2.4 and is working on
porting them to 2.6 but they are not yet ported.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
