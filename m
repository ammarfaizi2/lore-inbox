Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRB1RHb>; Wed, 28 Feb 2001 12:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbRB1RHV>; Wed, 28 Feb 2001 12:07:21 -0500
Received: from tmpsmtp704.honeywell.com ([199.64.7.104]:41478 "HELO
	tmpsmtp704.honeywell.com") by vger.kernel.org with SMTP
	id <S130270AbRB1RHP>; Wed, 28 Feb 2001 12:07:15 -0500
Date: Wed, 28 Feb 2001 17:07:07 +0000 (UTC)
From: matthew.copeland@honeywell.com
To: linux-kernel@vger.kernel.org
Subject: drivers/block/rd.c under 2.2.16
Message-ID: <Pine.LNX.4.21.0102281704130.8868-100000@fisb.gaa.aro.allied.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am attempting to get something figured out dealing with the ramdisk
under Linux 2.2.16.  I am trying to figure out whether you can use the
ramdisk to act as a RAM filesystem doing normal file creations and
deletion.  I noticed that within the code it makes comments about not
having to free stuff up.  Does that mean you can't delete things off the
ramdisk filesystem?  I have created a ramdisk, formatted ext2, and mounted
it.  When I create stuff on there, and then I delete it, I notice that if
I do a df, the size doesn't go back down after I have deleted the file.  
I am trying to figure out if that is how it was intended to happen, or
whether I have just done something not quite correctly and you can't
really use it as a RAM file system.

Thanks,
Matthew M. Copeland





