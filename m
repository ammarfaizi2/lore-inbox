Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278191AbRJLW64>; Fri, 12 Oct 2001 18:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278195AbRJLW6q>; Fri, 12 Oct 2001 18:58:46 -0400
Received: from [216.163.180.10] ([216.163.180.10]:56567 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S278191AbRJLW60>; Fri, 12 Oct 2001 18:58:26 -0400
Message-ID: <3BC7757A.CB01C83C@starband.net>
Date: Fri, 12 Oct 2001 18:58:03 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Evil scsi bug.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When ide-scsi is loaded, box a with a symbios scsi board does NOT work,
the scanner does not work.

Oct 12 18:39:23 p3 kernel: Attached scsi generic sg2 at scsi0, channel
0, id 3, lun 0,  type 6
Oct 12 18:39:23 p3 kernel: sym53c875-0-<3,*>: target did not report
SYNC.
Oct 12 18:39:23 p3 kernel: ide-scsi: The scsi wants to send us more data
than expected - discarding data
Oct 12 18:39:23 p3 kernel: ide-scsi: transferred 5 of 6 bytes

When I unload ide-scsi, and load the scsi module all by itself, it works
fine.
What an evil bug/problem!


With box b, I have an adaptec and ide-scsi both built into the kernel,
and they work great.

