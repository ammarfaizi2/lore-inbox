Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTAGQQL>; Tue, 7 Jan 2003 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTAGQQL>; Tue, 7 Jan 2003 11:16:11 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:62354 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267496AbTAGQQK>; Tue, 7 Jan 2003 11:16:10 -0500
Message-Id: <4.3.2.7.2.20030107171831.00b66a80@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Jan 2003 17:25:25 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.21-pre2 peculiarity
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a quiscent system, "gunzip" increases constantly.
See readprofile below.
Why ? I thought that was only used at boot time.

Margit

-- snip --
289018   gunzip                                                     194.2325
2924        __constant_c_and_count_memset       18.2750
1294       shmem_truncate_indirect                          5.7768
597         put_fs_struct                                               3.3920
961        s_show 
2.5026
155        shmem_zero_setup                                    1.6146
143        do_buffer_fdatasync                                   1.1172
296        read_events                                                 0.4405
295780 
total                                                               0.2134
-- end snip --

