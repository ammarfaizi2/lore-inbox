Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKVXGh>; Fri, 22 Nov 2002 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSKVXGh>; Fri, 22 Nov 2002 18:06:37 -0500
Received: from [66.62.77.7] ([66.62.77.7]:3243 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S265368AbSKVXGg>;
	Fri, 22 Nov 2002 18:06:36 -0500
Subject: 2.5.29 DAC960 compile failure "I am a non-portable driver"
From: Dax Kelson <dax@gurulabs.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 16:13:53 -0700
Message-Id: <1038006834.1623.1.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  gcc -E
-Wp,-MD,/usr/src/linux-2.5.29/include/linux/modules/drivers/block/.DAC960.ver.d -D__KERNEL__ -I/usr/src/linux-2.5.29/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=DAC960 -D__GENKSYMS__  DAC960.c | /sbin/genksyms  -k 2.5.29 > /usr/src/linux-2.5.29/include/linux/modules/drivers/block/DAC960.ver.tmp
In file included from DAC960.c:49:
DAC960.h:2575:2: #error I am a non-portable driver, please convert me to
use the Documentation/DMA-mapping.txt interfaces


