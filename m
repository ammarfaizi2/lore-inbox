Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271564AbTGRKMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271602AbTGRKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:11:59 -0400
Received: from [213.26.12.10] ([213.26.12.10]:23446 "HELO mail.robox.it")
	by vger.kernel.org with SMTP id S271826AbTGRKJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:09:46 -0400
Message-ID: <3F17CAE9.7070005@robox.it>
Date: Fri, 18 Jul 2003 12:24:41 +0200
From: Marco Lazzarotto <m.lazzarotto@robox.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030502 Debian/1.2.1-9woody3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ext3 / USB Mass Storage (the syslog file)
References: <3F17CA63.2050203@robox.it>
In-Reply-To: <3F17CA63.2050203@robox.it>
Content-Type: multipart/mixed;
 boundary="------------050808040404000102060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050808040404000102060206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I forgot the syslog file...

--------------050808040404000102060206
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Jul 18 09:16:17 marco kernel: hub.c: new USB device 00:1f.2-1, assigned address 3
Jul 18 09:16:17 marco kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jul 18 09:16:17 marco kernel:   Vendor: TwinMOS   Model: MOBILE Disk       Rev: 1.11
Jul 18 09:16:17 marco kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jul 18 09:16:17 marco kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Jul 18 09:16:17 marco kernel: SCSI device sda: 129024 512-byte hdwr sectors (66 MB)

[...]

Jul 18 11:38:01 marco kernel: hub.c: new USB device 00:1f.2-1, assigned address 6
Jul 18 11:38:01 marco kernel: WARNING: USB Mass Storage data integrity not assured
Jul 18 11:38:01 marco kernel: USB Mass Storage device found at 6
Jul 18 11:38:05 marco identd[23178]: started
Jul 18 11:38:13 marco kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 11:38:13 marco kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Jul 18 11:38:13 marco kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
Jul 18 11:38:13 marco kernel: EXT3-fs: recovery complete.
Jul 18 11:38:13 marco kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 11:38:55 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 40963
Jul 18 11:38:55 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 40964

[All blocks between 40964 and 41215 are present...]

Jul 18 11:39:24 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 41215
Jul 18 11:39:24 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 41216
Jul 18 11:39:35 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 49153
Jul 18 11:39:35 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 49154

[Again, all blocks are here...]

Jul 18 11:39:55 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 49407
Jul 18 11:39:55 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 49408
Jul 18 11:39:57 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 57347
Jul 18 11:39:57 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 57348

[And here, too...]

Jul 18 11:40:26 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 57599
Jul 18 11:40:26 marco kernel: EXT3-fs error (device sd(8,1)): ext3_new_block: Allocating block in system zone - block = 57600
Jul 18 11:40:40 marco kernel: EXT3-fs error (device sd(8,1)): ext3_free_blocks: Freeing blocks in system zones - Block = 57458, count = 256
Jul 18 11:40:40 marco kernel: EXT3-fs error (device sd(8,1)): ext3_free_blocks: Freeing blocks in system zones - Block = 57457, count = 1
Jul 18 11:40:40 marco kernel: Assertion failure in journal_forget() at transaction.c:1225: "!jh->b_committed_data"
Jul 18 11:40:40 marco kernel: kernel BUG at transaction.c:1225!
Jul 18 11:40:40 marco kernel: invalid operand: 0000
Jul 18 11:40:40 marco kernel: CPU:    0
Jul 18 11:40:40 marco kernel: EIP:    0010:[journal_forget+170/420]    Tainted: PF
Jul 18 11:40:40 marco kernel: EFLAGS: 00010282
Jul 18 11:40:40 marco kernel: eax: 00000058   ebx: c1c71490   ecx: c203e000   edx: cfe5bd00
Jul 18 11:40:40 marco kernel: esi: c5da2000   edi: c9943980   ebp: cf4fb8c0   esp: c203fd2c
Jul 18 11:40:40 marco kernel: ds: 0018   es: 0018   ss: 0018
Jul 18 11:40:40 marco kernel: Process rm (pid: 23458, stackpage=c203f000)
Jul 18 11:40:40 marco kernel: Stack: c02be7a0 c02bed13 c02be780 000004c9 c02bed22 00000000 c459ada0 c953ed80 
Jul 18 11:40:40 marco kernel:        c953ed80 c5da2094 c015080b c459ada0 c9943980 0000e003 c27eea48 c459ada0 
Jul 18 11:40:40 marco kernel:        c4991d20 0000e003 c27eea48 c459ada0 c0152490 c459ada0 00000000 c953ed80 
Jul 18 11:40:40 marco kernel: Call Trace:    [ext3_forget+107/232] [ext3_clear_blocks+256/296] [journal_get_write_access+64/88] [ext3_free_data+251/352] [ext3_free_branches+512/528]
Jul 18 11:40:40 marco kernel:   [bread+24/100] [ext3_free_branches+204/528] [bread+24/100] [ext3_free_branches+204/528] [ext3_truncate+200/932] [ext3_truncate+703/932]
Jul 18 11:40:40 marco kernel:   [journal_start+149/196] [start_transaction+85/128] [ext3_delete_inode+0/292] [ext3_delete_inode+167/292] [ext3_delete_inode+0/292] [iput+259/504]
Jul 18 11:40:40 marco kernel:   [d_delete+76/124] [vfs_unlink+340/388] [sys_unlink+153/268] [system_call+51/56]
Jul 18 11:40:40 marco kernel: 
Jul 18 11:40:40 marco kernel: Code: 0f 0b c9 04 80 e7 2b c0 83 c4 14 53 e8 ed 02 00 00 c7 43 14 
Jul 18 11:41:05 marco identd[23525]: started

--------------050808040404000102060206--

