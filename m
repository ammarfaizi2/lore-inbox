Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRGYJRg>; Wed, 25 Jul 2001 05:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266781AbRGYJR0>; Wed, 25 Jul 2001 05:17:26 -0400
Received: from web11502.mail.yahoo.com ([216.136.172.47]:17925 "HELO
	web11502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266746AbRGYJRK>; Wed, 25 Jul 2001 05:17:10 -0400
Message-ID: <20010725091716.71588.qmail@web11502.mail.yahoo.com>
Date: Wed, 25 Jul 2001 02:17:16 -0700 (PDT)
From: Satish Kumar <m_satish@yahoo.com>
Subject: bdev manipulation at block layer level
To: linux-kernel@vger.kernel.org
Cc: m_satish@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I have a host PC connected to a disk array with
alternate paths to an end scsi disk. 
I attempted load balancing across paths by changing
the b_dev & b_rdev ib the bufer_head list in
ll_rw_block function of ll_rw_blk.c (block layer), and
was successful in load balancing with data integrity,
on linux 2.2.16.
However, when I try the same stunt with a linux 2.4 (
&2.4.2) kernel, I am seeing corruption occasionally.
Can anyone let me know if I am missing anything ?

Thanks !

regards,
Satish.






__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
