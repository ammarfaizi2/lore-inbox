Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292211AbSBOWJV>; Fri, 15 Feb 2002 17:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292212AbSBOWJB>; Fri, 15 Feb 2002 17:09:01 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:38178 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S292211AbSBOWI4>; Fri, 15 Feb 2002 17:08:56 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F1C@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'axboe@burns.home.kernel.dk'" <axboe@burns.home.kernel.dk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.5.5pre1 /drivers/block/rd.c using nr_sectors
Date: Fri, 15 Feb 2002 17:07:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if your the one to contact, but compiling 2.5.5pre1 errored out
compiling the ramdisk driver in /drivers/block/rd.c because it is still
using bi_end_io with the nr_sectors Argument.  I simply removed the
nr_sectors arg to make the kernel compile past that point.  I don't know if
that's the right route to go, but wanted to let someone know. 

Thanks,
Bruce H.
