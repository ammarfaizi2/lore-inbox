Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTL1I2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 03:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTL1I2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 03:28:06 -0500
Received: from sina187-158.sina.com.cn ([202.106.187.158]:46596 "HELO sina.com")
	by vger.kernel.org with SMTP id S265030AbTL1I2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 03:28:04 -0500
Date: Sun, 28 Dec 2003 16:26:46 +0800
From: dlion <dlion2004@sina.com.cn>
X-Mailer: The Bat! (v2.00)
Reply-To: dlion2004@sina.com.cn
X-Priority: 3 (Normal)
Message-ID: <1593963906.20031228162646@sina.com.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
In-Reply-To: <17140565218.20031226223021@sina.com.cn>
References: <8BD3ED34-37A6-11D8-A9B5-00039341E01A@ybb.ne.jp>
 <17140565218.20031226223021@sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bxynj>> Hi,

 >>>I got other errors on ext3 filesystem include:
 >>>1. missing file
 >>>2. corrupted file
 >>>but when I used fsck.ext3 to check the ramdisk, the result was clean.

Bxynj>> Dlion,  how did the corrupted file look like?
Bxynj>> (its file size, number of blocks etc.)

d> 3. maybe all corrupted files' mtime is exactly the same
d> wrong value. Should be around 2003.12.26 21:30:00, but
d> is 2002.05.12 12:00:48(hex value is 0x3cdde8f0) . ctime
d> and atime is correct. The system's clock time is unchanged.

Sorry. I have made a mistake. The mtime is correct, not damaged.
It is set by tar.



