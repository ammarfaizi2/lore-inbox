Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRLBOqY>; Sun, 2 Dec 2001 09:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282887AbRLBOqO>; Sun, 2 Dec 2001 09:46:14 -0500
Received: from relay-1m.club-internet.fr ([195.36.216.170]:28115 "HELO
	relay-1m.club-internet.fr") by vger.kernel.org with SMTP
	id <S279768AbRLBOqE>; Sun, 2 Dec 2001 09:46:04 -0500
Message-ID: <3C0A3EB2.7090802@freesurf.fr>
Date: Sun, 02 Dec 2001 15:46:10 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011130
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: linux-2.5.1-pre5 failed to compile (module ide-tape.c)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing 'make modules':

gcc -D__KERNEL__ -I/usr/src/linux-2.5.1-pre5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE   -c -o ide-tape.o ide-tape.c
ide-tape.c: In function `idetape_input_buffers':
ide-tape.c:1512: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_output_buffers':
ide-tape.c:1538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_update_buffers':
ide-tape.c:1565: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_active_next_stage':
ide-tape.c:1738: structure has no member named `bh'
ide-tape.c: In function `__idetape_kfree_stage':
ide-tape.c:1785: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_cmd':
ide-tape.c:2538: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_read_buffer_cmd':
ide-tape.c:2570: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_create_write_cmd':
ide-tape.c:2587: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_do_request':
ide-tape.c:2621: warning: long int format, unsigned int arg (arg 4)
ide-tape.c:2745: structure has no member named `bh'
ide-tape.c:2762: structure has no member named `bh'
ide-tape.c:2767: structure has no member named `bh'
ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2834: structure has no member named `b_reqnext'
ide-tape.c:2866: structure has no member named `b_reqnext'
ide-tape.c:2871: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_from_user':
ide-tape.c:2920: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_copy_stage_to_user':
ide-tape.c:2947: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_queue_rw_tail':
ide-tape.c:3448: structure has no member named `bh'
ide-tape.c: In function `idetape_verify_stage':
ide-tape.c:3656: structure has no member named `b_reqnext'
ide-tape.c: In function `idetape_empty_write_pipeline':
ide-tape.c:3861: structure has no member named `b_reqnext'
ide-tape.c:3864: structure has no member named `b_reqnext'
ide-tape.c:3876: structure has no member named `b_reqnext'
ide-tape.c:3844: warning: `bh' might be used uninitialized in this function
ide-tape.c: In function `idetape_pad_zeros':
ide-tape.c:4150: structure has no member named `b_reqnext'

-- 
  ** Gael Le Mignot, Ing3 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Web       : http://kilobug.freesurf.fr or http://drizzt.dyndns.org

"Software is like sex it's better when it's free.", Linus Torvalds

