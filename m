Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUAOWmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUAOWmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:42:13 -0500
Received: from northuist.CNS.CWRU.Edu ([129.22.104.60]:18045 "EHLO
	ims-msg.TIS.CWRU.Edu") by vger.kernel.org with ESMTP
	id S263592AbUAOWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:42:00 -0500
Date: Thu, 15 Jan 2004 17:20:53 -0500
From: Jim Garrison <garrison@case.edu>
Subject: 2.6.1 compile error - drivers/block/swim3.c (powerpc)
To: linux-kernel@vger.kernel.org
Message-id: <1074205253.636.11.camel@ibook>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know that gcc 3.3.2 is not an officially supported compiler, but this
error seems to be of the generic kind.  swim3.c fails to compile for me
on powerpc.

Please CC me in any replies.

Thanks,
Jim Garrison



  CC      drivers/block/swim3.o
drivers/block/swim3.c:224: error: parse error before '*' token
drivers/block/swim3.c:224: warning: function declaration isn't a
prototype
drivers/block/swim3.c:292: error: parse error before '*' token
drivers/block/swim3.c:293: warning: function declaration isn't a
prototype
drivers/block/swim3.c: In function `do_fd_request':
drivers/block/swim3.c:302: warning: implicit declaration of function
`sti'
drivers/block/swim3.c: In function `start_request':
drivers/block/swim3.c:315: warning: implicit declaration of function
`elv_next_request'
drivers/block/swim3.c:315: warning: assignment makes pointer from
integer without a cast
drivers/block/swim3.c:324: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:324: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:325: warning: implicit declaration of function
`end_request'
drivers/block/swim3.c:328: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:337: warning: implicit declaration of function
`rq_data_dir'
drivers/block/swim3.c:346: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:347: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `set_timeout':
drivers/block/swim3.c:363: warning: implicit declaration of function
`save_flags'
drivers/block/swim3.c:363: warning: implicit declaration of function
`cli'
drivers/block/swim3.c:371: warning: implicit declaration of function
`restore_flags'
drivers/block/swim3.c: In function `setup_transfer':
drivers/block/swim3.c:422: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:430: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:431: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:443: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:447: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `xfer_timeout':
drivers/block/swim3.c:598: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:599: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:601: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `swim3_interrupt':
drivers/block/swim3.c:623: warning: long unsigned int format, int arg
(arg 3)
drivers/block/swim3.c:695: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:696: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:697: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:706: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:715: warning: long unsigned int format, int arg
(arg 3)
drivers/block/swim3.c:721: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:722: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:723: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:724: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `floppy_ioctl':
drivers/block/swim3.c:817: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `floppy_open':
drivers/block/swim3.c:843: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `floppy_release':
drivers/block/swim3.c:909: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `floppy_check_change':
drivers/block/swim3.c:920: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `floppy_revalidate':
drivers/block/swim3.c:926: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c: In function `swim3_init':
drivers/block/swim3.c:999: warning: implicit declaration of function
`alloc_disk'
drivers/block/swim3.c:999: warning: assignment makes pointer from
integer without a cast
drivers/block/swim3.c:1004: error: `FLOPPY_MAJOR' undeclared (first use
in this function)
drivers/block/swim3.c:1004: error: (Each undeclared identifier is
reported only once
drivers/block/swim3.c:1004: error: for each function it appears in.)
drivers/block/swim3.c:1009: warning: implicit declaration of function
`blk_init_queue'
drivers/block/swim3.c:1009: warning: assignment makes pointer from
integer without a cast
drivers/block/swim3.c:1017: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1018: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1019: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1020: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1021: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1022: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1023: error: dereferencing pointer to incomplete
type
drivers/block/swim3.c:1024: warning: implicit declaration of function
`set_capacity'
drivers/block/swim3.c:1025: warning: implicit declaration of function
`add_disk'drivers/block/swim3.c:1033: warning: implicit declaration of
function `put_disk'drivers/block/swim3.c: In function
`swim3_add_device':
drivers/block/swim3.c:1084: warning: implicit declaration of function
`request_irq'
drivers/block/swim3.c: At top level:
drivers/block/swim3.c:962: warning: `floppy_off' defined but not used
make[2]: *** [drivers/block/swim3.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


