Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRB1CUn>; Tue, 27 Feb 2001 21:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRB1CUd>; Tue, 27 Feb 2001 21:20:33 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:60485 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S130038AbRB1CUV>;
	Tue, 27 Feb 2001 21:20:21 -0500
Message-ID: <3A9C6184.9050802@brocade.com>
Date: Tue, 27 Feb 2001 18:25:08 -0800
From: Amit D Chaudhary <amitc@brocade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mke2fs hangs while running on /dev/loop0 - kernel version 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am hoping someone knows more about this case. I have a intel pc 
running linux 2.4 and the last command below hangs and the statements as 
they are printed. Even kill -9 does not get it to terminate.

#touch img.test
#dd if=/dev/zero of=img.test bs=1k count=2000
2000+0 records in
2000+0 records out
#losetup /dev/loop0 img.test
#mke2fs

mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
256 inodes, 2000 blocks
100 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
256 inodes per group

Writing inode tables: done
......

Thanks
Amit

