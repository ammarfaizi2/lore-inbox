Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273028AbRIWAi4>; Sat, 22 Sep 2001 20:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273037AbRIWAir>; Sat, 22 Sep 2001 20:38:47 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:34952 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S273028AbRIWAid>;
	Sat, 22 Sep 2001 20:38:33 -0400
Message-ID: <3BAD2F22.6E151CBD@pobox.com>
Date: Sat, 22 Sep 2001 17:38:58 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Robert Love <rml@tech9.net>
Subject: Encouraging results from 2.4.10-pre14 + preempt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am very encouraged by the latest linus kernel, and
thought I'd pass this along -

Platform info -
----------------
PIII 933/Intel mobo
512 MB RAM
2 30 GB IDE disks
Ensoniq ES1371 sound card
Red Hat 7.1 + bits of rawhide
kernel 2.4.10-pre14 + preempt patch

The testing was done while running X windows (icewm), Netscape 4.78,
iptraf, and misc other services (named, sendmail, apache, iptables
firewalling etc.

During the dbench runs mpg123 was playing mp3s -

Highlights -
------------
 - There was absolutely no mp3 skipping during dbench 16 & 32.
 - There was minor skipping during dbench 40, when load was near 40.
 - Best of all, the desktop remained completely responsive the entire
time.


dbench summaries:
---------------------------
Throughput 49.6162 MB/sec (NB=62.0202 MB/sec  496.162 MBit/sec)  16
procs
Throughput 32.5531 MB/sec (NB=40.6913 MB/sec  325.531 MBit/sec)  32
procs
Throughput 24.8711 MB/sec (NB=31.0889 MB/sec  248.711 MBit/sec)  40
procs


Screenshot at http://mirai.cx/dbench40.png

