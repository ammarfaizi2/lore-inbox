Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318055AbSGRM5V>; Thu, 18 Jul 2002 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318051AbSGRM5V>; Thu, 18 Jul 2002 08:57:21 -0400
Received: from [210.78.134.243] ([210.78.134.243]:2052 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S318048AbSGRM5U>;
	Thu, 18 Jul 2002 08:57:20 -0400
Date: Thu, 18 Jul 2002 21:2:28 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem of linux-2.4.19
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207182104579.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i met some problem with linux2.4.19. i devided my disk to three partitions: hda1,hda2 and hda3.  hda3 is the swap. both hda1 and hda2 are ext3 file system. i boot the system with a initrd image which is saved on hda1.
  when i use linux-2.4.19-pre1 and pre2, the system worked well. but when i test linux-2.4.19-pre9,pre10,rc1 and rc2, the same problem happened to all these verions. the system boot up, but the filesystem is readonly.the following is what on the screen(not exactly):
..
mount root as readonly
INIT version is 2.78
swap on(swap priority -1)
..
  is there some bugs in linux-2.4.19 with the filesystem? or with the initrd boot? or i made some mistakes?

  please cc. thanks.

zhengchuanbo
zhengcb@netpower.com.cn

