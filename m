Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTBQLe7>; Mon, 17 Feb 2003 06:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTBQLe7>; Mon, 17 Feb 2003 06:34:59 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:42510 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267027AbTBQLe6>; Mon, 17 Feb 2003 06:34:58 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: ext3 clings to you like flypaper
Date: Mon, 17 Feb 2003 11:44:56 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b2qhvo$pva$1@news.cistron.nl>
References: <78320000.1045465489@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1045482296 26602 62.216.29.200 (17 Feb 2003 11:44:56 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <78320000.1045465489@[10.10.2.4]>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>Added a journal to my root disk.
>Mounted it ext3.
>set my fstab back to ext2
>reboot.
>Disk says it's mounted ext2 ("mount\n")
>Mmmmm ... it STILL mounts ext3.
>Allegedly this is a "feature".
>Can we please remove this stupidity?

The kernel does not read /etc/fstab when it mounts the root filesystem.
Chicken - egg.

Edit /etc/lilo.conf and set rootfstype.

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

