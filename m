Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbREaFBW>; Thu, 31 May 2001 01:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263017AbREaFBL>; Thu, 31 May 2001 01:01:11 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:34059 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S263015AbREaFA7>; Thu, 31 May 2001 01:00:59 -0400
Date: Thu, 31 May 2001 10:48:11 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: one link missing for a directory
In-Reply-To: <Pine.LNX.4.10.10105261033470.16037-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10105311041570.21497-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry to disturb you.

I tried to create a file system similar to ramfs on 2.2.14 kernel. I was
able to insert it as a module and mount it to ram disk at /dev/ram0 at a
mount point called /mnt. It gets mounted . But after mounting it the link
count of directory /mnt becomes 1 and size becomes 0 which was previously
4096.
What might be the problem. In my file system I have implemented only
directory lookup and readdir functions. Which function takes care of the
link count and the size of the directory. It would be very helpful for me
if you could answer this so that I can proceed with my implementation.

Thanks in advance,

Regards,
sathish


