Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282275AbRLMFNT>; Thu, 13 Dec 2001 00:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282934AbRLMFNK>; Thu, 13 Dec 2001 00:13:10 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:20494 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S282275AbRLMFNC>;
	Thu, 13 Dec 2001 00:13:02 -0500
Message-ID: <3C1838FA.1010802@si.rr.com>
Date: Thu, 13 Dec 2001 00:13:30 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre10: drivers/ide/ide-tape.c compile error
Content-Type: multipart/mixed;
 boundary="------------050307020300070000000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307020300070000000703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
   I haven't seen this posted yet. While a 'make modules' on 
2.5.1-pre10, I received the attached compile error on 
drivers/ide/ide-tape.c . I noticed this with 2.5.1-pre9 as well. I don't 
recall seeing it with 2.5.1-pre7, and I'm using the same .config .

Regards,
Frank

--------------050307020300070000000703
Content-Type: text/plain;
 name="IDE-TAPE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-TAPE"

make -C ide modules
make[2]: Entering directory `/usr/src/linux/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o ide-tape.o ide-tape.c
ide-tape.c: In function `idetape_input_buffers':
ide-tape.c:1512: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_output_buffers':
ide-tape.c:1538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_update_buffers':
ide-tape.c:1565: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_abort_pipeline':
ide-tape.c:1709: warning: comparison between pointer and integer
ide-tape.c:1710: incompatible types in assignment
ide-tape.c:1711: warning: comparison between pointer and integer
ide-tape.c:1712: incompatible types in assignment
ide-tape.c: In function `idetape_active_next_stage':
ide-tape.c:1738: structure has no member named `bh'
ide-tape.c: In function `__idetape_kfree_stage':
ide-tape.c:1785: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_end_request':
ide-tape.c:1871: warning: comparison between pointer and integer
ide-tape.c:1911: warning: comparison between pointer and integer
ide-tape.c: In function `idetape_queue_pc_head':
ide-tape.c:1987: incompatible types in assignment
ide-tape.c: In function `idetape_create_read_cmd':
ide-tape.c:2540: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_buffer_cmd':
ide-tape.c:2572: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_write_cmd':
ide-tape.c:2589: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_do_request':
ide-tape.c:2621: warning: int format, pointer arg (arg 4)
ide-tape.c:2623: warning: long int format, int arg (arg 4)
ide-tape.c:2626: warning: comparison between pointer and integer
ide-tape.c:2626: warning: comparison between pointer and integer
ide-tape.c:2630: warning: int format, pointer arg (arg 3)
ide-tape.c:2664: warning: comparison between pointer and integer
ide-tape.c:2677: warning: comparison between pointer and integer
ide-tape.c:2677: warning: comparison between pointer and integer
ide-tape.c:2691: warning: comparison between pointer and integer
ide-tape.c:2696: warning: comparison between pointer and integer
ide-tape.c:2703: warning: int format, pointer arg (arg 2)
ide-tape.c:2721: warning: comparison between pointer and integer
ide-tape.c:2732: switch quantity not an integer
ide-tape.c:2747: structure has no member named `bh'
ide-tape.c:2764: structure has no member named `bh'
ide-tape.c:2769: structure has no member named `bh'
ide-tape.c:2772: incompatible types in assignment
ide-tape.c:2780: incompatible types in assignment
ide-tape.c:2785: incompatible types in assignment
ide-tape.c:2734: warning: unreachable code at beginning of switch statement
ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2836: structure has no member named `b_reqnext'
ide-tape.c:2868: structure has no member named `b_reqnext'
ide-tape.c:2873: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_from_user':
ide-tape.c:2922: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_to_user':
ide-tape.c:2949: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_wait_for_request':
ide-tape.c:3080: warning: comparison between pointer and integer
ide-tape.c:3080: warning: comparison between pointer and integer
ide-tape.c: In function `__idetape_queue_pc_tail':
ide-tape.c:3188: incompatible types in assignment
ide-tape.c: In function `idetape_queue_rw_tail':
ide-tape.c:3450: structure has no member named `bh'
ide-tape.c:3451: incompatible types in assignment
ide-tape.c: In function `idetape_onstream_read_back_buffer':
ide-tape.c:3500: incompatible types in assignment
ide-tape.c: In function `idetape_verify_stage':
ide-tape.c:3658: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_add_chrdev_write_request':
ide-tape.c:3775: incompatible types in assignment
ide-tape.c: In function `idetape_empty_write_pipeline':
ide-tape.c:3863: structure has no member named `b_reqnext'
ide-tape.c:3866: structure has no member named `b_reqnext'
ide-tape.c:3878: structure has no member named `b_reqnext'
ide-tape.c:3846: warning: `bh' might be used uninitialized in this function
ide-tape.c: In function `idetape_initiate_read':
ide-tape.c:3963: incompatible types in assignment
ide-tape.c: In function `idetape_pad_zeros':
ide-tape.c:4152: structure has no member named `b_reqnext'
make[2]: *** [ide-tape.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ide'
make[1]: *** [_modsubdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

--------------050307020300070000000703--

