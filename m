Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbSKQCQR>; Sat, 16 Nov 2002 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbSKQCQR>; Sat, 16 Nov 2002 21:16:17 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:37380 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267434AbSKQCQQ>; Sat, 16 Nov 2002 21:16:16 -0500
Date: Sun, 17 Nov 2002 10:21:34 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jeff Chua <jchua@fedex.com>
cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: VFAT mount (bug or feature?
In-Reply-To: <Pine.LNX.4.44.0211170944020.432-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.44.0211171019550.524-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/17/2002
 10:23:08 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/17/2002
 10:23:11 AM,
	Serialize complete at 11/17/2002 10:23:11 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Jeff Chua wrote:

> But, 2.4.20-rc2 seems ok.
>
> 'mount -o umask=022' now works under 2.4.20-rc2.

"remount" doesn't work.

mount -o umask=022 -t vfat /dev/hda1 /dos
mount -o umask=000 -o remount -t vfat /dev/hda1 /dos

The above didn't work.

umount /dos
mount -o umask=022 -t vfat /dev/hda1 /dos
umount /dos
mount -o umask=000 -t vfat /dev/hda1 /dos


Jeff


