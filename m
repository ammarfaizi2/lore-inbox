Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUEBR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUEBR0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUEBR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 13:26:37 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:65441 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263182AbUEBR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 13:26:33 -0400
Message-ID: <40952E29.2070903@t-online.de>
Date: Sun, 02 May 2004 19:21:45 +0200
From: mikeb1@t-online.de (Michael Berger)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031007
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Error in installing kernel 2.6.5 compiled with GCC 3.4.0 and
 -mregparm=3
References: <408BBCB2.9010804@t-online.de> <m2d65n2hw9.fsf@p4.localdomain>
In-Reply-To: <m2d65n2hw9.fsf@p4.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: rIveBMZLYenO92jr93vfl8Frij0XAkTdosVL91IUpqnb-jNhQBphca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Peter

Thank you for your reply. I receive LKML through my ISP. I have only 
this messages in my messages file:

===============================================================================================

Apr 25 12:58:55 Loki modprobe: FATAL: Error inserting loop 
(/lib/modules/2.6.5/kernel/drivers/block/loop.ko): Invali
d module format
Apr 25 12:58:55 Loki kernel: loop: version magic '2.6.5 PENTIUMIII 
REGPARM gcc-3.4' should be '2.6.5 PENTIUMIII gcc-
3.4'
Apr 25 12:58:55 Loki modprobe: FATAL: Error inserting loop 
(/lib/modules/2.6.5/kernel/drivers/block/loop.ko): Invali
d module format
Apr 25 12:58:55 Loki kernel: loop: version magic '2.6.5 PENTIUMIII 
REGPARM gcc-3.4' should be '2.6.5 PENTIUMIII gcc-
3.4'
Apr 25 13:01:13 Loki modprobe: FATAL: Error inserting loop 
(/lib/modules/2.6.5/kernel/drivers/block/loop.ko): Invali
d module format
Apr 25 13:01:13 Loki kernel: loop: version magic '2.6.5 PENTIUMIII 
REGPARM gcc-3.4' should be '2.6.5 PENTIUMIII gcc-
3.4'
Apr 25 13:01:13 Loki modprobe: FATAL: Error inserting loop 
(/lib/modules/2.6.5/kernel/drivers/block/loop.ko): Invali
d module format
Apr 25 13:01:13 Loki kernel: loop: version magic '2.6.5 PENTIUMIII 
REGPARM gcc-3.4' should be '2.6.5 PENTIUMIII gcc-
3.4'
Apr 25 13:18:04 Loki kernel: loop: loaded (max 8 devices)

==================================================================================================

This is after I rebooted the machine with the "new kernel" compiled with 
-mregparm=3. For the installation I loaded by hand the loop
and ext2 module and installed the kernel. After rebooting I have now 
this messages in my log files. I switched back to without
-mregparm=3 kernel 2.6.5 and this messages are away. I will do more 
tests on a scratch box and with different config files and compilers.

Best regards,

Michael

