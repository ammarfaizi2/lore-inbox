Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbTDIMkb (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDIMkb (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:40:31 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:32384 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263296AbTDIMka (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 08:40:30 -0400
Message-ID: <3E941701.3332151F@cinet.co.jp>
Date: Wed, 09 Apr 2003 21:50:09 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.67-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: A test report of  2.5.67-ac1 IDE using PIO mode
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested new IDE driver of 2.5.67-ac1 using PC-9800.
PC-9800 has PIO mode only.
Simple load test by coping 100000 files (total 2GB) to same drive.
2.5.67 vanilla has no problem.
On 2.5.67-ac1, cp command completed with no error message.
But e2fsck reported over 100 files containing mismatch between
directory and inode.

Regards,
Osamu Tomita <tomita@cinet.co.jp>
