Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTAORoe>; Wed, 15 Jan 2003 12:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTAORoe>; Wed, 15 Jan 2003 12:44:34 -0500
Received: from [199.26.153.9] ([199.26.153.9]:55958 "EHLO smtp.fourelle.com")
	by vger.kernel.org with ESMTP id <S266755AbTAORod>;
	Wed, 15 Jan 2003 12:44:33 -0500
Message-ID: <3E25A0D1.1020004@fourelle.com>
Date: Wed, 15 Jan 2003 09:56:33 -0800
From: Adam Scislowicz <adams@fourelle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 (ramdisk device naming at boot time(/dev/ramdisk/<n>) vs.
 after devfs is mounted(/dev/rd/<n>))
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4.20 kernel, when using DEVFS the ramdisk naming is 
inconsistent. /dev/ramdisk/0 works for the kernel parameter initrd=
while /dev/rd/0 works in fstab.
For clarity: before DEVFS loads it must be referenced as /dev/ramdisk/0, 
yet DEVFS registers /dev/rd/<n>

/)dam.. .  . D o n ' t   S t o p

