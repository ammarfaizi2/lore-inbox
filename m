Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbRBCXJ3>; Sat, 3 Feb 2001 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131098AbRBCXJU>; Sat, 3 Feb 2001 18:09:20 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:23997 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130843AbRBCXJF>; Sat, 3 Feb 2001 18:09:05 -0500
Message-ID: <3A7C8F78.F8E23A18@Home.net>
Date: Sat, 03 Feb 2001 18:08:41 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PS hanging 2.4.1 - Isolated
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@coredump /proc]# cd 9338
[root@coredump 9338]# ls

Feb  3 17:57:08 coredump kernel: gnomeicu  S 0000CD17     0  9338
1        (NOTLB)    9340  9332
Feb  3 17:57:08 coredump kernel: Call Trace: [search_by_key+203/3232]
[search_for_position_by_key+170/916] [make_cpu_key+57/64] [$
Feb  3 17:57:08 coredump kernel:        [<f0000000>]
[reiserfs_get_block+158/3408] [search_for_position_by_key+170/916]
[search_f$
Feb  3 17:57:08 coredump kernel:        [block_read_full_page+246/552]
[add_to_page_cache_unique+202/212] [reiserfs_readpage+15/2$
Feb  3 17:57:08 coredump kernel:        [do_page_fault+312/1020]
[do_page_fault+0/1020] [start_request+388/508] [intlat_local_irq$
Feb  3 17:57:09 coredump kernel:        [__generic_copy_from_user+52/60]
[opost_block+67/384] [handle_mm_fault+232/340] [add_wait$
Feb  3 17:57:09 coredump kernel:        [system_call+62/80

whats happening here?

Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
