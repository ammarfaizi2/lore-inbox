Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTIYXkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTIYXkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:40:40 -0400
Received: from mta07bw.bigpond.com ([144.135.24.134]:26067 "EHLO
	mta07bw.bigpond.com") by vger.kernel.org with ESMTP id S262062AbTIYXkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:40:39 -0400
Date: Fri, 26 Sep 2003 09:41:58 +1000
From: gb <gillian.bennett@celentia.com>
Subject: 2.4.20-20.9
To: linux-kernel@vger.kernel.org
Message-id: <1064533319.1361.119.camel@rh-possum>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

not sure if this is the right list to try, but I have tried a few now
and not found an answer to my problem so I thought I would just give
this a shot. 

I have just installed 2.4.20-20.9 kernel on my RH9 machine. At boot up,
it gets as far through rc.sysinit to try to e2fsck / and then halts with
the error:

Checking root filesystem
/dev/hda3 is mounted. e2fsck: Cannont continue, aborting.

The command just before this error is :

initlog -c 'fsck -T -a -C /'

it exits with a return code of 8 (operational error)

boot loader is grub, and the stanza's look identical. I used the rpm
version of the kernel so it was all pretty much done for me. I haven't
yet tried compiling my own kernel because I wanted to sort out this
problem first.

I also have the old kernel still available and it boots without error.
Could you please tell me where I can read about fixing this problem, or
maybe some things I can try?

Thanks, gillian


