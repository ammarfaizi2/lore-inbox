Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRHBRQB>; Thu, 2 Aug 2001 13:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRHBRPv>; Thu, 2 Aug 2001 13:15:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35273 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266921AbRHBRPk>; Thu, 2 Aug 2001 13:15:40 -0400
Date: Thu, 2 Aug 2001 13:15:48 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108021715.f72HFmY07505@devserv.devel.redhat.com>
To: Andrej.Borsenkow@mow.siemens.ru, linux-kernel@vger.kernel.org
Subject: Re: Persistent device numbers
In-Reply-To: <mailman.996733981.23626.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.996733981.23626.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I understand, currently kernel assigns device numbers dynamically.

That's why mount by label exists

[zaitcev@niphredil zaitcev]$ cat /etc/fstab
LABEL=/                 /                       ext2    defaults        1 1
/dev/fd0                /mnt/floppy             auto    noauto,owner    0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/pts                devpts  gid=5,mode=620  0 0

> Do I miss something and Linux has such mechanism?

Not really... Gooch says it is needed and he has a patch for it,
check it out too. Most of it can be resolved by other means.

-- Pete
