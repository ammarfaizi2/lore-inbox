Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKMRYd>; Tue, 13 Nov 2001 12:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRKMRYN>; Tue, 13 Nov 2001 12:24:13 -0500
Received: from ns1.deanox.com ([209.197.23.235]:28946 "EHLO server.deanox.com")
	by vger.kernel.org with ESMTP id <S276094AbRKMRYI>;
	Tue, 13 Nov 2001 12:24:08 -0500
Message-Id: <3.0.6.32.20011113102417.00e29540@server.deanox.com>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 13 Nov 2001 10:24:17 -0700
To: Tim Waugh <twaugh@redhat.com>
From: Lee Howard <faxguy@deanox.com>
Subject: Re: lp oops with kernel 2.4.15-pre2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011113113029.N25718@redhat.com>
In-Reply-To: <3.0.6.32.20011112165757.00e404b0@server.deanox.com>
 <3.0.6.32.20011112165757.00e404b0@server.deanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:30 AM 11/13/01 +0000, Tim Waugh wrote:
>On Mon, Nov 12, 2001 at 04:57:57PM -0700, Lee Howard wrote:
>
>> Nov 12 12:02:44 zelda kernel: EIP:    0010:[kmem_cache_alloc+100/176]
>[...]
>> Nov 12 12:02:44 zelda kernel: Call Trace: [d_alloc+23/368] [sprintf+18/32]
>> [sock_map_fd+153/352] [unix_create+92/112] [sock_create+214/256] 
>> Nov 12 12:02:44 zelda kernel:    [dentry_open+346/384] [sys_socket+41/80]
>> [sys_socketcall+96/464] [do_page_fault+0/1200] [error_code+52/60]
>> [system_call+51/56] 
>
>This doesn't seem to be lp- or parport-related.  What else was the
>machine doing at the time?

This oops occurred at the moment of processing/handling a print job.  The
print jobs are processed via a Samba printer share.  The system is also
constantly running a MySQL database that is accessed via Apache+PHP.

So, the system is running MySQL, Samba, Apache, PHP, sendmail, lpd, and
various other things standard on an updated RedHat 7.0 system (I'm
upgrading kernels via tarball).

Lee.

