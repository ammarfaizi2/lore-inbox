Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUDGNiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUDGNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:38:07 -0400
Received: from sea2-f12.sea2.hotmail.com ([207.68.165.12]:10002 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263565AbUDGNiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:38:04 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: panic when adding root=/LABEL=/  in grub.conf - newbie
Date: Wed, 07 Apr 2004 16:37:57 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F121U1x4ykaaEv0001bc59@hotmail.com>
X-OriginalArrivalTime: 07 Apr 2004 13:37:58.0865 (UTC) FILETIME=[8A4C3C10:01C41CA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am working with kenel 2.4.20 on Intel x86.
Now I Had downloaded a kernel source to a different folder and build it.
I added an entry in grub.conf
When I choose to load that kernel everything is OK.
It works wth no problem.
But under /boot I see nothing of the original files (there is only one file 
there , kernel.h).

The output of mount  is :

/dev/hda3 on / type ext3 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)

when I add the following in grub.conf (to the option of choosing to load 
this kernel)

root=/LABEL=/

I get the the following panic message:
VFS: cannot open root device = "LABEL=/" or 00:00
Please append a correct "root= "  boot option.
Kernel panic : VFS: unable to mount root fs on 00:00

Any idea?
Any help will be appreciated.

Sting

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

