Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbSKPPrZ>; Sat, 16 Nov 2002 10:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSKPPrZ>; Sat, 16 Nov 2002 10:47:25 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:65287 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267299AbSKPPrY>; Sat, 16 Nov 2002 10:47:24 -0500
Date: Sat, 16 Nov 2002 23:52:42 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: re: VFAT mount (bug or feature?
Message-ID: <Pine.LNX.4.44.0211162349160.1208-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/16/2002
 11:54:15 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/16/2002
 11:54:19 PM,
	Serialize complete at 11/16/2002 11:54:19 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Nov 13, 2002 at 01:47:04AM +0100, Udo A. Steinberg wrote:

>> In my /etc/fstab I have the following entry:
>>
>> /dev/hda1  /win   vfat   defaults,umask=022  1 1
>>
>> Why does 2.5.47 have user/group restricted permissions on the mount
>> point and all its subdirectories, despite the umask setting?

> Yes. This is due to a somewhat buggy change in 2.5.43.

This is buggy in 2.4.20-rc1 as well.

drwxr--r--   40 root     root         4096 Jan  1  1970 /dos

Any patch for 2.4.20-rcx?


Thanks,
Jeff
[ jchua@fedex.com ]

