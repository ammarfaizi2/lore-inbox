Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRLVT3x>; Sat, 22 Dec 2001 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282099AbRLVT3n>; Sat, 22 Dec 2001 14:29:43 -0500
Received: from cm61-15-169-117.hkcable.com.hk ([61.15.169.117]:385 "EHLO
	cm61-15-169-117.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S282080AbRLVT32>; Sat, 22 Dec 2001 14:29:28 -0500
Message-ID: <3C24DE45.5080102@rcn.com.hk>
Date: Sun, 23 Dec 2001 03:25:57 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Override file permissions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

In a case of permission deny on dentry_open(). Is it possible to overide
that in the kernel?

Process context calls remain the same EUID of user space, is there any 
way to override that in the kernel, since we might have something 
prviledge to do with. dentry_open() is made in my own file system.

Thanks.

David

