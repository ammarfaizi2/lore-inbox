Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbREWUXo>; Wed, 23 May 2001 16:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbREWUXZ>; Wed, 23 May 2001 16:23:25 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:49141 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S263246AbREWUXQ>; Wed, 23 May 2001 16:23:16 -0400
Message-ID: <3B0C1C27.D8D4D280@bigfoot.com>
Date: Wed, 23 May 2001 13:23:03 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p2aa1-a i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Mielke <dave@mielke.cc>
CC: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount by label not working.
In-Reply-To: <Pine.LNX.4.30.0105231505330.995-100000@dave.private.mielke.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v2.10r works.

[tim@abit tim]# mount -V
mount: mount-2.10r
[tim@abit tim]# tune2fs -L spare /dev/hda10
tune2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
[tim@abit tim]# mount -L spare /mnt
[tim@abit tim]# df /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda10             3028080   2100116    927964  69% /mnt
[tim@abit tim]# cat /proc/version
Linux version 2.2.20p2aa1-a (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 Sat May 19 18:46:38 PDT 2001

Dave Mielke wrote:
> 
> Using kernel 2.2.17-14 as supplied by RedHat, and using mount from
> mount-2.9u-4, mounting by label using the -L option does not work.
> 
>     mount -L backup1 /a
>     mount: no such partition found
...
> Does something need to be enabled to make this work? What else might I be doing
> wrong?


--
