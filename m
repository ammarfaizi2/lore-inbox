Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSLQSlZ>; Tue, 17 Dec 2002 13:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLQSlZ>; Tue, 17 Dec 2002 13:41:25 -0500
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:39431 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S265413AbSLQSlX>; Tue, 17 Dec 2002 13:41:23 -0500
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <20BF5713E14D5B48AA289F72BD372D680211A8D7@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: nikberry@med.umich.edu, root@chaos.analogic.com, sanju93csd@yahoo.co.in
cc: linux-kernel@vger.kernel.org
Subject: RE: How to get the size of the block device ???? (Important)
Date: Tue, 17 Dec 2002 12:49:09 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11E1AE27943669-02-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the question being asked is 'how do I find out how many block
> long the device is?'

You can use the BLKGETSIZE64 ioctl() too.  I refer you to the GNU Parted
code (ftp.gnu.org/gnu/parted) in libparted/linux.c to see how it's done
there.  It first tries BLKGETSIZE64, then if that fails, tries BLKGETSIZE
instead.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

