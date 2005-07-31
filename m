Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVGaWV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVGaWV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVGaWV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:21:26 -0400
Received: from delta.securenet-server.net ([72.9.248.26]:10905 "EHLO
	delta.securenet-server.net") by vger.kernel.org with ESMTP
	id S261998AbVGaWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:19:09 -0400
Message-ID: <42ED4E53.2010508@machinehasnoagenda.com>
Date: Mon, 01 Aug 2005 08:18:59 +1000
From: "Shayne O'Connor" <forums@machinehasnoagenda.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: realtime-preempt-2.6.13-rc4-RT-V0.7.52-07
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: forums@machinehasnoagenda.com,machine@machinehasnoagenda.com,shunichi@machinehasnoagenda.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - machinehasnoagenda.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trying to compile 2.6.13.rc4 with ingo's RT patch 
(realtime-preempt-2.6.13-rc4-RT-V0.7.52-07) but keep getting this error 
near the end of compilation:

   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
net/built-in.o(.text+0x2220c): In function `rt_check_expire':
: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x2222e): In function `rt_check_expire':
: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x22321): In function `rt_run_flush':
: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x22339): In function `rt_run_flush':
: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x22593): In function `rt_garbage_collect':
: undefined reference to `__bad_spinlock_type'
net/built-in.o(.text+0x225c1): more undefined references to 
`__bad_spinlock_type' follow
make: *** [.tmp_vmlinux1] Error 1
[mrmachine@localhost linux-2.6.12]$


i am trying to compile it with PREEMPT_DESKTOP ....


(please CC me on any replies!)


shayne
