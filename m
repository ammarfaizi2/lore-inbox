Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUASLlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUASLlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:41:19 -0500
Received: from [81.196.41.18] ([81.196.41.18]:56486 "EHLO
	msa31a.ms.sapientia.ro") by vger.kernel.org with ESMTP
	id S264534AbUASLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:41:10 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: msa31a.ms.sapientia.ro
Message-ID: <400BC220.6070909@ms.sapientia.ro>
Date: Mon, 19 Jan 2004 13:40:16 +0200
From: Budai Laszlo <lbudai@ms.sapientia.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No module sym53c8xx found for kernel 2.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I try to compile the 2.6.1 kernel downloaded from www.kernel.org.

Everything seems ok until I give the "make install" command when I got 
the following message:

[root@fuji linux-2.6.1]# make install
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /root/linux-2.6.1/arch/i386/boot/install.sh 2.6.1 
arch/i386/boot/bzImage System.map ""
No module sym53c8xx found for kernel 2.6.1
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2


The module sym53c8xx is in the linux-2.6.1/drivers/scsi/sym53c8xx_2 
directory but it seems that there is some problem with it.

Does anyone know what to do in order to get the new kernel working?

Thank you,
Laszlo


