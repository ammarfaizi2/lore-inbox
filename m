Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVIURv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVIURv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVIURvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:51:55 -0400
Received: from iotaanl.aps.anl.gov ([164.54.56.3]:25794 "EHLO iota.aps.anl.gov")
	by vger.kernel.org with ESMTP id S1751343AbVIURvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:51:36 -0400
Message-ID: <43319DA0.6030300@aps.anl.gov>
Date: Wed, 21 Sep 2005 12:51:28 -0500
From: Shifu Xu <xusf@aps.anl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Red Hat/1.7.10-1.1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rt14 build problem on Powerpc board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

I tried the patch-2.6.13-rt14 on mvme2100 board,  the following are the 
build message:
hope it get fixed.
Thanks

Shifu

------------------------------
 CC      kernel/posix-cpu-timers.o
In file included from kernel/posix-cpu-timers.c:6:
include/linux/posix-timers.h: In function `forward_posix_timer':
include/linux/posix-timers.h:106: warning: comparison of distinct 
pointer types lacks a cast
  CC      kernel/ktimers.o
  CC      kernel/ntp.o
kernel/ntp.c:84: error: parse error before "__cacheline_aligned_in_smp"
kernel/ntp.c:84: warning: type defaults to `int' in declaration of 
`__cacheline_aligned_in_smp'
kernel/ntp.c:84: warning: excess elements in scalar initializer
kernel/ntp.c:84: warning: (near initialization for 
`__cacheline_aligned_in_smp')
kernel/ntp.c:84: warning: data definition has no type or storage class
kernel/ntp.c: In function `ntp_advance':
kernel/ntp.c:104: error: `ntp_lock' undeclared (first use in this function)
kernel/ntp.c:104: error: (Each undeclared identifier is reported only once
kernel/ntp.c:104: error: for each function it appears in.)
kernel/ntp.c:104: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:104: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:104: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:104: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:209: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:209: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:209: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:209: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c: In function `ntp_adjtimex':
kernel/ntp.c:346: error: `ntp_lock' undeclared (first use in this function)
kernel/ntp.c:346: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:346: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:346: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:346: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:418: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:418: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:418: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:418: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c: In function `ntp_leapsecond':
kernel/ntp.c:442: error: `ntp_lock' undeclared (first use in this function)
kernel/ntp.c:442: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:442: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:442: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:442: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:485: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:485: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:485: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:485: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c: In function `ntp_clear':
kernel/ntp.c:497: error: `ntp_lock' undeclared (first use in this function)
kernel/ntp.c:497: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:497: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:497: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:497: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:507: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:507: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:507: warning: type defaults to `int' in declaration of 
`type name'
kernel/ntp.c:507: warning: type defaults to `int' in declaration of 
`type name'
make[1]: *** [kernel/ntp.o] Error 1
make: *** [kernel] Error 2

