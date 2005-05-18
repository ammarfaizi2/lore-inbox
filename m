Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVERTWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVERTWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVERTWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:22:39 -0400
Received: from mail.tyan.com ([66.122.195.4]:18181 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262236AbVERTWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:22:24 -0400
Message-ID: <3174569B9743D511922F00A0C943142309F80FE2@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: "Ronald G. Minnich" <rminnich@lanl.gov>, ebiederman@lnxi.com,
       Stefan Reinauer <stepan@openbios.org>, Li-Ta Lo <ollie@lanl.gov>
Cc: linuxbios@openbios.org, Matt Mackall <mpm@selenic.com>,
       linux-tiny@selenic.com, linux-kernel@vger.kernel.org
Subject: Next step with LinuxBIOS
Date: Wed, 18 May 2005 12:42:31 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with Linuxtiny,  I enable the 
1. serial console
2. tcp/ip
3. smp ( i need apic...)
4. usb storage
5. lsi scsi disk
6. ide

the kernel get 682k.

actually space for normal payloads is 1024-128-90=806k.

how about the next step?
another small program to provide 
1. menu support
2. flash
3. cmos setting
4. boot from Net.. (copy to ramdisk and kexec)
5. boot from disk...(kexec...)

the small program in ramdisk or initramfs...?

Please comment

YH
