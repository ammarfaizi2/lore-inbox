Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTE0Q0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbTE0Q0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:26:07 -0400
Received: from web14904.mail.yahoo.com ([216.136.225.56]:27512 "HELO
	web14904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263930AbTE0Q0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:26:06 -0400
Message-ID: <20030527162304.61687.qmail@web14904.mail.yahoo.com>
Date: Tue, 27 May 2003 12:23:04 -0400 (EDT)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Different dev name in inode structure
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a question about the inode structure. My
kernel version is 2.4.7-10, Red Hat Linux 7.2

In fs.h header file I found the prototype of inode
structure. In this inode structure there are the
following definitions.

kdev_t i_dev;
kdev_t i_rdev;
struct block_device * i_bdev;
struct char_device * i_cdev;

My question is what is the exact difference of i_dev
and i_rdev? Which one I should use?

Another question is what that i_bdev and i_cdev are
used for? They stand for what? 

Thanks

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
