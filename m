Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUBAXjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUBAXjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:39:16 -0500
Received: from sputnik.bioma.se ([212.112.42.34]:46984 "EHLO sputnik.bktv.se")
	by vger.kernel.org with ESMTP id S265552AbUBAXjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:39:09 -0500
Message-ID: <401D8E17.1020805@lmpnet.se>
Date: Mon, 02 Feb 2004 00:39:03 +0100
From: Michael Jonsson <micke@lmpnet.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smbfs build error kernel-2.6.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get an error when I try to build kernel-2.6.1 with smbfs,

************************************************
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC [M]  fs/smbfs/proc.o
fs/smbfs/proc.c:33:19: proto.h: No such file or directory
fs/smbfs/proc.c: In function `smb_request_ok':
fs/smbfs/proc.c:826: warning: implicit declaration of function 
`smb_add_request'
fs/smbfs/proc.c: In function `smb_newconn':
fs/smbfs/proc.c:874: warning: implicit declaration of function 
`smb_valid_socket'
fs/smbfs/proc.c:903: error: `smb_data_ready' undeclared (first use in 
this function)
fs/smbfs/proc.c:903: error: (Each undeclared identifier is reported only 
once
fs/smbfs/proc.c:903: error: for each function it appears in.)
fs/smbfs/proc.c:968: error: `smb_dir_inode_operations_unix' undeclared 
(first use in this function)
fs/smbfs/proc.c:981: warning: implicit declaration of function 
`smbiod_wake_up'
fs/smbfs/proc.c: In function `smb_proc_seek':
fs/smbfs/proc.c:1071: warning: implicit declaration of function 
`smb_alloc_request'
fs/smbfs/proc.c:1071: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c:1088: warning: implicit declaration of function `smb_rput'
fs/smbfs/proc.c: In function `smb_proc_open':
fs/smbfs/proc.c:1121: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_open':
fs/smbfs/proc.c:1192: warning: implicit declaration of function 
`smb_renew_times'
fs/smbfs/proc.c: In function `smb_proc_close':
fs/smbfs/proc.c:1215: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_close_inode':
fs/smbfs/proc.c:1270: warning: implicit declaration of function 
`smb_get_inode_attr'
fs/smbfs/proc.c: In function `smb_proc_read':
fs/smbfs/proc.c:1339: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_write':
fs/smbfs/proc.c:1387: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_readX':
fs/smbfs/proc.c:1461: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_writeX':
fs/smbfs/proc.c:1507: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_create':
fs/smbfs/proc.c:1551: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_mv':
fs/smbfs/proc.c:1584: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_generic_command':
fs/smbfs/proc.c:1619: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_unlink':
fs/smbfs/proc.c:1690: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_flush':
fs/smbfs/proc.c:1742: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_trunc64':
fs/smbfs/proc.c:1776: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_readdir_short':
fs/smbfs/proc.c:1978: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c:2065: warning: implicit declaration of function 
`smb_fill_cache'
fs/smbfs/proc.c: In function `smb_proc_readdir_long':
fs/smbfs/proc.c:2308: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_getattr_ff':
fs/smbfs/proc.c:2512: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_getattr_core':
fs/smbfs/proc.c:2594: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_getattr_trans2_std':
fs/smbfs/proc.c:2679: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_getattr_trans2_all':
fs/smbfs/proc.c:2729: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_getattr_unix':
fs/smbfs/proc.c:2760: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_setattr_core':
fs/smbfs/proc.c:2846: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_setattr_ext':
fs/smbfs/proc.c:2908: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_setattr_trans2':
fs/smbfs/proc.c:2954: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_setattr_unix':
fs/smbfs/proc.c:3028: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_dskattr':
fs/smbfs/proc.c:3179: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_read_link':
fs/smbfs/proc.c:3209: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_symlink':
fs/smbfs/proc.c:3258: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_link':
fs/smbfs/proc.c:3301: warning: assignment makes pointer from integer 
without a cast
fs/smbfs/proc.c: In function `smb_proc_query_cifsunix':
fs/smbfs/proc.c:3346: warning: assignment makes pointer from integer 
without a cast
make[2]: *** [fs/smbfs/proc.o] Error 1
make[1]: *** [fs/smbfs] Error 2
make: *** [fs] Error 2
***********************************************************

Regards
Micke


