Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVDYBWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVDYBWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 21:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVDYBWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 21:22:39 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:51902 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262395AbVDYBW3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 21:22:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fNpwZBtsubhKCsqfXfszdQ0uyczW5ksUqCU9FTRFcqCCEzi4nTdFORob4knkKknRH+a22BmisKR3DyW5wDXOs+9dkYD4kjdJI7J8bGbQHuAUWMiMZIG3tYs9mw6EZji/9TjCM3HCbh7mxTAcFpVDwrt8ZC4iVAN0MQxZUKKcuXM=
Message-ID: <4ae3c14050424182235f916d7@mail.gmail.com>
Date: Sun, 24 Apr 2005 21:22:29 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ext3+ramdisk journaling problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I used ramdisk as an ext3 journal and mount ext3 file system with
option data=journal. It worked fine and speedup the ext3 file system.
However, After I reboot the system and try to mount that ext3
filesystem,  the system reported:

mount: wrong fs type, bad option, bad superblock on /dev/hda2,
       or too many mounted file systems

This gave me a feeling taht the ramdisk is not a right journal
anymore.  Any solution to this problem? Also, how to ensure that the
journal stored on the ramdisk is committed to ext3 filesystem before
it is umounted?  Any commands to do this?

THanks in advance for your kind help.

Xin
