Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTBEXDq>; Wed, 5 Feb 2003 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTBEXDq>; Wed, 5 Feb 2003 18:03:46 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:49422
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S265130AbTBEXDo>; Wed, 5 Feb 2003 18:03:44 -0500
Message-ID: <3E419A43.7070100@rackable.com>
Date: Wed, 05 Feb 2003 15:12:03 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa1
References: <20030131014020.GA8395@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 23:13:16.0235 (UTC) FILETIME=[29DDA9B0:01C2CD6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the dac960 compile still broken?  Or did it break again?

make[3]: Entering directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
gcc -D__KERNEL__ -I/stuff/src/linux-2.4.21-pre4-aa1/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=DAC960  -DEXPORT_SYMTAB 
-c DAC960.c
DAC960.c: In function `DAC960_ProcessCompletedBuffer':
DAC960.c:3029: warning: passing arg 1 of `blk_finished_io' makes pointer 
from integer without a cast
DAC960.c:3029: too few arguments to function `blk_finished_io'
make[3]: *** [DAC960.o] Error 1
make[3]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers'
make: *** [_dir_drivers] Error 2

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



