Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266039AbSKFTIg>; Wed, 6 Nov 2002 14:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbSKFTIg>; Wed, 6 Nov 2002 14:08:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51474 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266039AbSKFTIf>; Wed, 6 Nov 2002 14:08:35 -0500
Message-ID: <3DC96A1C.20805@namesys.com>
Date: Wed, 06 Nov 2002 22:14:36 +0300
From: Yury Umanets <umka@namesys.com>
Organization: NAMESYS
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: reiserfs-dev@Namesys.COM, Linux-Kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] build failure: reiser4progs-0.1.0
References: <200211052145.gA5Ljdr32055@mail.osdl.org>
In-Reply-To: <200211052145.gA5Ljdr32055@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:

>Attempting to test reiser4, kernel 2.5.46, using the 2002.11.05 snapshot.
>--------------------------------------------------
>gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include -g -O2 -D_REENTRANT 
>-D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -Werror 
>-DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -c alloc40.c -MT alloc40.lo -MD -MP 
>-MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
>cc1: warnings being treated as errors
>alloc40.c: In function `callback_fetch_bitmap':
>alloc40.c:50: warning: signed and unsigned type in conditional expression
>alloc40.c: In function `callback_flush_bitmap':
>alloc40.c:209: warning: signed and unsigned type in conditional expression
>alloc40.c: In function `callback_check_bitmap':
>alloc40.c:376: warning: signed and unsigned type in conditional expression
>make[3]: *** [alloc40.lo] Error 1
>make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
>oc40'
>make[2]: *** [all-recursive] Error 1
>make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
>make[1]: *** [all-recursive] Error 1
>make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
>make: *** [all] Error 2
>-------------------------------------
>cliffw
>
>
>
>
>  
>
You are probably using gcc-3.2. Okay, fixed. Thanks a lot for report.

-- 
Yury Umanets


