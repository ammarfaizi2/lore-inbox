Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290674AbSA3WPK>; Wed, 30 Jan 2002 17:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSA3WNe>; Wed, 30 Jan 2002 17:13:34 -0500
Received: from argus.posten.se ([147.14.10.164]:36227 "HELO argus.posten.se")
	by vger.kernel.org with SMTP id <S290662AbSA3WNE>;
	Wed, 30 Jan 2002 17:13:04 -0500
Message-ID: <3C5870E2.7030102@mysun.com>
Date: Wed, 30 Jan 2002 23:17:06 +0100
From: Pawel Worach <pawel.worach@mysun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020130
X-Accept-Language: en, en-us, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.3 won't compile (i810_audio)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new i810_audio driver merged into 2.5.3 won't compile.
Here is the result:

gcc -D__KERNEL__ -I/usr/src/kernel/2.5/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE   -c -o i810_audio.o i810_audio.c
i810_audio.c: In function `i810_mmap':
i810_audio.c:1673: warning: passing arg 1 of `remap_page_range' makes 
pointer from integer without a cast
i810_audio.c:1673: incompatible type for argument 4 of `remap_page_range'
i810_audio.c:1673: too few arguments to function `remap_page_range'
make[2]: *** [i810_audio.o] Error 1

../Pawel

