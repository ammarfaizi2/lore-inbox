Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264078AbSIQMZH>; Tue, 17 Sep 2002 08:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264090AbSIQMZH>; Tue, 17 Sep 2002 08:25:07 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:62940 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264078AbSIQMZG>; Tue, 17 Sep 2002 08:25:06 -0400
Message-Id: <5.1.0.14.2.20020917132943.00b239e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 17 Sep 2002 13:31:01 +0100
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: route inode->block_device in 2.5?
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200209121622.g8CGMgP07303@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:22 12/09/02, Peter T. Breuer wrote:
>Is there a pointer chain by which one can get to the struct
>block_device of the underlying block device from an inode?

struct inode->i_sb (== struct super_block)->s_bdev (== struct block_device).

Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

