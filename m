Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSKVXLu>; Fri, 22 Nov 2002 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKVXLt>; Fri, 22 Nov 2002 18:11:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265369AbSKVXLt>;
	Fri, 22 Nov 2002 18:11:49 -0500
Date: Fri, 22 Nov 2002 15:17:21 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dax Kelson <dax@gurulabs.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.29 DAC960 compile failure "I am a non-portable driver"
In-Reply-To: <1038006834.1623.1.camel@mentor>
Message-ID: <Pine.LNX.4.33L2.0211221515420.6580-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Nov 2002, Dax Kelson wrote:

|   gcc -E
| -Wp,-MD,/usr/src/linux-2.5.29/include/linux/modules/drivers/block/.DAC960.ver.d -D__KERNEL__ -I/usr/src/linux-2.5.29/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=DAC960 -D__GENKSYMS__  DAC960.c | /sbin/genksyms  -k 2.5.29 > /usr/src/linux-2.5.29/include/linux/modules/drivers/block/DAC960.ver.tmp
| In file included from DAC960.c:49:
| DAC960.h:2575:2: #error I am a non-portable driver, please convert me to
| use the Documentation/DMA-mapping.txt interfaces

2.5.29 ?  really?

There are DAC960 patches for recent 2.5.x kernels at
  http://www.osdl.org/archive/dmo/
Please try one of them after moving to a more recent kernel.

-- 
~Randy

