Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRGYE3k>; Wed, 25 Jul 2001 00:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbRGYE3a>; Wed, 25 Jul 2001 00:29:30 -0400
Received: from [210.77.38.126] ([210.77.38.126]:30224 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S266536AbRGYE3Q>; Wed, 25 Jul 2001 00:29:16 -0400
Date: Thu, 26 Jul 2001 12:30:37 +0800
From: michael chen <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <16912463234.20010726123037@turbolinux.com.cn>
To: =?ISO-8859-1?B?0MIg1MI=?= <xinyuepeng@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[8]: How to change the root filesystem
In-Reply-To: <20010725033411.38884.qmail@web20004.mail.yahoo.com>
In-Reply-To: <20010725033411.38884.qmail@web20004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello 新,

Wednesday, July 25, 2001, 11:34:11 AM, you wrote:

性> Hi michaelc:
性>    I do it,but meet:
性>    VFS: Cannot open root device "2100" or 21:00
性>    Please append a correct "root=" boot option
性>   <0>Kernel panic: VFS: Unable to mount root fs on
性> 21:00
      Ok, I think you use SCSI generic driver to support your scsi device,
  Is that right? Why do you want to use SCSI generic instead of SCSI
  disk?
      The message told you that kernel couldn't load the SCSI device driver,
  You must build the SCSI device driver(I don't know what SCSI
  device you are using) in or use initrd.
     IF you don't build you root filesystem(e.g.  cramfs) in, it will
  also cause the problem.
      


-- 
Best regards,
 michael                            mailto:michaelc@turbolinux.com.cn


