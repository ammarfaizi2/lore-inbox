Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSLPMxk>; Mon, 16 Dec 2002 07:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSLPMxk>; Mon, 16 Dec 2002 07:53:40 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:10978 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S266676AbSLPMxj>; Mon, 16 Dec 2002 07:53:39 -0500
Message-ID: <3DFE789B.9020507@ToughGuy.net>
Date: Tue, 17 Dec 2002 06:36:35 +0530
From: Bourne <bourne@ToughGuy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Unmounting a busy RO-Filesystem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 partitions. /dev/hda3 for '/' , /dev/hda1 for /boot and 
/dev/hda2 for swap.

I boot & then i do a CTRL+ALT+SYSRQ+U.  '/' and '/boot' are now 
remounted ReadOnly.

1) cd '/boot'
2) umount /boot ----> This gives me an error "Device Busy"
3) cd /
4) umount / -------> No error
5) echo $? -----> outputs '0' indicating success. !!!!!!!!

When i do the above by skipping the Sysrq part, i get the usual expected 
errors.

So is the above behaviour expected ? I tried this on 2.4.19 & 2.5.51. 
Same results.

I am subscribed to the list

TIA
Bourne

