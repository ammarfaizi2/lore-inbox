Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265842AbRFYCM4>; Sun, 24 Jun 2001 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRFYCMf>; Sun, 24 Jun 2001 22:12:35 -0400
Received: from mailout4-1.nyroc.rr.com ([24.92.226.166]:52705 "EHLO
	mailout4-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S265842AbRFYCMb>; Sun, 24 Jun 2001 22:12:31 -0400
Message-Id: <200106250212.WAA05336@soyata.home>
To: linux-kernel@vger.kernel.org
Subject: mounting a fs in two places at once?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5331.993435148.1@soyata.home>
Date: Sun, 24 Jun 2001 22:12:29 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed redhat 7.1 on a system.

Cleaning up, a made a fs for home...(mounted on /mnt
to write the stuff to it)

Then I accidently mounted it on /home.

So it was mounted on /home and /mnt at the same time.
(I didn't bother going in to see what was there).
Shouldn't this NOT happen?
[root@pb /]# mount
/dev/hda9 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hda5 on /boot type ext2 (rw)
/dev/hda7 on /usr type ext2 (rw)
/dev/hda6 on /var type ext2 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
automount(pid603) on /misc type autofs (rw,fd=5,pgrp=603,minproto=2,maxproto=3)
pb:(pid704) on /net type nfs (intr,rw,port=1023,timeo=8,retrans=110,indirect,ma
p=/etc/amd.net,dev=00000007)
/dev/hda10 on /mnt type ext2 (rw)
/dev/hda10 on /home type ext2 (rw)


Is this a feature or a bug?

This is with 2.4.2...



Marty Leisner
leisner@rochester.rr.com

